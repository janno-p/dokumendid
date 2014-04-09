class CreateDocStatusTypes < ActiveRecord::Migration
  def change
    create_table :doc_status_type, :primary_key => 'doc_status_type' do |t|
      t.string :type_name, limit: 200
    end
  end
end
