class MapsController < ApplicationController
  before_action :set_map, only: [:show, :edit, :update, :destroy]
  layout :resolve_layout
  before_filter :require_permission, only: [:edit, :destroy]

  # GET /maps
  # GET /maps.json
  def index
    @maps = Map.all	
	@public = Map.public_maps
	
    if params[:search]
      @public = Map.search(params[:search]).order("created_at DESC")
    else
      @public = Map.all.order('created_at DESC')
    end	
	
  end
  
  def my_maps
    @maps = Map.all	
  end

  # GET /maps/1
  # GET /maps/1.json
  def show
  end

  # GET /maps/new
  def new
    @map = Map.new	
  end

  # GET /maps/1/edit
  def edit
  end

  # POST /maps
  # POST /maps.json
  def create
    @map = Map.new(map_params)
	@map.user_id = current_user.id	
    respond_to do |format|
      if @map.save
        format.html { redirect_to @map, notice: 'Map was successfully created.' }
        format.json { render :show, status: :created, location: @map }
      else
        format.html { render :new }
        format.json { render json: @map.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /maps/1
  # PATCH/PUT /maps/1.json
  def update
    respond_to do |format|
      if @map.update(map_params)
        format.html { redirect_to @map, notice: 'Map was successfully updated.' }
        format.json { render :show, status: :ok, location: @map }
      else
        format.html { render :edit }
        format.json { render json: @map.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /maps/1
  # DELETE /maps/1.json
  def destroy
    @map.destroy
    respond_to do |format|
      format.html { redirect_to maps_url, notice: 'Map was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def download  
	@map = Map.find(params[:id])	
		
		content = @map.content
		background = @map.background_color
		background_node = @map.node_background_color
		background_stroke = @map.node_stroke_color		
		
		
		full_path_to_read = "#{Rails.root}/public/download/map.html"
		full_path_to_write = "#{Rails.root}/public/download/map2.html"

		File.open(full_path_to_read) do |source_file|
		  contents = source_file.read
		  contents.gsub!(/MindmapHTMLContentGoesBelow/, content)
		  contents.gsub!(/MindmapBackgroundColorGoesBelow/, background)
		  contents.gsub!(/MindmapNodeBackgroundColorGoesBelow/, background_node)
		  contents.gsub!(/MindMapStrokeColorGoesBelow/, background_stroke)
		  File.open(full_path_to_write, "w+") { |f| f.write(contents) }
		end
		
		#=begin
		#File.open("#{Rails.root}/public/download/map.html", 'r+'){|file|
		#while (!file.eof?)
		#  line = file.readline
		#  if (line.starts_with?("<!-- Mindmap HTML Content Goes Below -->"))
		#	file.write(content)				
		#  end
		#end
		#}	
		#=end
		
		
		send_file Rails.root.join('public','download','map2.html'), :x_sendfile=>true	
	
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_map
      @map = Map.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def map_params
      params.require(:map).permit(:name, :content, :user_id, :description, :is_public, :background_color, :node_background_color, :node_stroke_color)
    end
	
	#resolve layout
	def resolve_layout
		case action_name
		when "show"
		  "showMap"		
		else
		  "application"
		end
	end	
	
	def require_permission
	  if current_user != Map.find(params[:id]).user
		redirect_to root_path
		#Or do something else here
	end
	
end
end
