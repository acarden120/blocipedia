class SetWikidefault < ActiveRecord::Migration
  def change
  	change_column_default :wikis, :wiki_private, false
  end
end
