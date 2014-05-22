class CollectionsController < ApplicationController
  before_action :set_collection, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /collections
  # GET /collections.json
  def index
    #@collections = Collection.where(user: current_user)
    #@publishes = Publish.where(publish_id: @collections)

    @user = User.find(params[:user_id])
    @publishes = Publish.joins(:collections).where("collections.user_id = ?", @user.id)
    # filter by category
    if params[:publish_category]

        category_id = "%"
        if params[:publish_category] != 'all'
          @category = PublishCategory.find_by(name: params[:publish_category])
          if @category.nil?
          else
            category_id = @category.id
          end
        end
        # LIKE %
        @publishes = @publishes.where("publishes.publish_category_id LIKE ?", category_id)

        render "index", layout: "works"
    end
    

  end

  # GET /collections/1
  # GET /collections/1.json
  def show
  end

  # GET /collections/new
  def new
    @collection = Collection.new
  end

  # GET /collections/1/edit
  def edit
  end

  # POST /collections
  # POST /collections.json
  def create
    #@collection = Collection.new(collection_params)
    @collection = current_user.collections.new
    @collection.user = current_user
    @collection.publish_id = params[:publish_id]

    respond_to do |format|
      if @collection.save
        # format.html { redirect_to user_collection_path(current_user, @collection), notice: 'Collection was successfully created.' }
        format.html {redirect_to user_collections_path(current_user), notice: t("flash.notices.collection_added")}
        format.json { render action: 'show', status: :created, location: @collection }
      else
        format.html { render head: :unprocessable_entity }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /collections/1
  # PATCH/PUT /collections/1.json
  def update
    respond_to do |format|
      if @collection.update(collection_params)
        format.html { redirect_to @collection, notice: 'Collection was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collections/1
  # DELETE /collections/1.json
  def destroy
    @publishes = Publish.joins(:collections).where("collections.user_id = ?", current_user.id)
    @collection.destroy
    respond_to do |format|
      format.html { render partial: "collection", object: @publishes }
      format.json { render head: no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collection
      @collection = Collection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def collection_params
      params.require(:collection).permit(:user_id, :publish_id)
    end
end
