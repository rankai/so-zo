RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    #show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  #for jcrop
  config.model User do
    navigation_icon 'icon-user'
    configure :photo, :jcrop

    #what edit will show
    edit do
      field :name
      field :password
      field :password_confirmation
      field :sex
      field :occupation
      field :phone
      field :address
      field :motto
      #field :description, :ck_editor do
      #end
      field :description
      field :roles
      field :tags
      field :photo do
        jcrop_options aspectRatio: 500.0/320.0
      end
    end

    # what list will show
    list do
      field :name
      field :roles
      field :sex
      field :occupation
      field :phone
      field :address
    end

  end


 #order fields
  config.model Product do
    edit do
      field :name
      field :description
      field :state
      field :price
      field :base_price
      field :publish
      field :product_template
      field :product_images
    end
  end

config.model ProductTemplate do
    edit do
      field :template_name
      field :template_category
      field :price
      field :brief
      field :description, :ck_editor do
      end
      field :sizes
      field :colors
      field :position_X
      field :position_Y
      field :size_X
      field :size_Y
      field :degree
      field :if_zoom
      field :head_image
      field :head_image_mask
      field :back_image
      field :back_image_mask
      field :side_image
      field :side_image_mask
    end
  end

  config.model Rich do
    visible false
  end

end
