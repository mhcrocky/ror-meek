require 'zip'

class Background < ActiveRecord::Base
  enum locations: { homepage_guest: 0 }

  validates :line_1, :background_slider_body, :background_slider_header, :location, presence: true
  validates :location, uniqueness: true

  after_commit :un_zip_file

  has_attached_file :background_slider, path: ":rails_root/public/system/background/:basename.:extension"

  validates_attachment_content_type :background_slider, content_type:  'application/zip'

  private

  def un_zip_file
    zipfile_path = self.background_slider.path
    return if Rails.env.test?
    zipfolder_path = File.dirname(zipfile_path)
    Zip::File.open( zipfile_path ) do |zip_file|
      zip_file.each do |f|
        f_path = File.join( zipfolder_path, f.name )
        FileUtils.mkdir_p( File.dirname( f_path ) )
        zip_file.extract( f, f_path ) unless File.exist?( f_path )
      end
    end

    remove_from_public
    copy_to_public( zipfile_path )
  end

  def remove_from_public
    FileUtils.rm_rf( Dir.glob( Rails.root.join( Rails.public_path, 'js', '*' )))
    FileUtils.rm_rf( Dir.glob( Rails.root.join( Rails.public_path, 'css', '*' )))
    FileUtils.rm_rf( Dir.glob( Rails.root.join( Rails.public_path, 'fonts', '*' )))
  end

  def copy_to_public(zipfile_path)
    slider_folder_path = zipfile_path.gsub('.zip', '')

    FileUtils.cp_r( slider_folder_path + '/js',     Rails.public_path )
    FileUtils.cp_r( slider_folder_path + '/css',    Rails.public_path )
    FileUtils.cp_r( slider_folder_path + '/fonts',  Rails.public_path )
  end
end
