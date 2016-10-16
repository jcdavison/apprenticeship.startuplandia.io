class CreateApplicants < ActiveRecord::Migration[5.0]
  def change
    enable_extension "hstore"
    create_table :applicants do |t|
      t.string :github
      t.hstore :application
      t.string :email

      t.timestamps
    end
  end
end
