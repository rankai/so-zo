class CreateProductTemplates < ActiveRecord::Migration
  def change
    create_table :product_templates do |t|

      t.string     :template_name
      t.text       :description
      t.string     :template_path

      t.timestamps
    end
  end
end
