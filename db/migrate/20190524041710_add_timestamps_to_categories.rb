class AddTimestampsToCategories < ActiveRecord::Migration[5.2]
  def change
  add_timestamps :categories, default: DateTime.now
  change_column_default :categories, :created_at, from: DateTime.now, to: nil
  change_column_default :categories, :updated_at, from: DateTime.now, to: nil
  end
end
