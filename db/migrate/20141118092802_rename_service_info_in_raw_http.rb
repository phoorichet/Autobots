class RenameServiceInfoInRawHttp < ActiveRecord::Migration
  def change
    rename_column :raw_https, :service_info, :serviceinfo
  end
end
