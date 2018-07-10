class RenameColumnOnVehicleTable < ActiveRecord::Migration[5.2]
  def change
    rename_column :vehicles, :max_atmosphere_speed, :max_atmosphering_speed
  end
end
