class AddAttributesToApplicant < ActiveRecord::Migration[5.0]
  def change
    add_column :applicants, :linkedin, :string
    add_column :applicants, :personal_site, :string
  end
end
