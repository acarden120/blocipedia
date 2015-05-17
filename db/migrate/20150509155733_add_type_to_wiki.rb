class AddTypeToWiki < ActiveRecord::Migration
  def change
    add_column :wikis, :wiki_private, :boolean
  end
end
