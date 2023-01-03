class ChangeStaticPageDatas < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      UPDATE static_pages
         SET name = 'About',
             slug = 'about'
       WHERE name = 'Advertise'
    SQL
  end

  def down
    execute <<-SQL
      UPDATE static_pages
         SET name = 'Advertise',
             slug = 'advertise'
       WHERE name = 'About'
    SQL
  end
end
