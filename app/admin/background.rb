ActiveAdmin.register Background do
  config.filters = false
  config.batch_actions = false

  permit_params :id, :line_1, :background_slider_body, :background_slider_header, :location, :title, :description, :background_slider, :section_1,
                :section_2, :section_3, :section_4, :logged_in_header

  index do
    column 'Location' do |background|
      Background.locations.keys[background.location].humanize
    end
    column :section_1
    column :logged_in_header
    column :section_2
    column :section_3
    column :section_4
    actions
  end

  form multipart: true do |f|
    f.inputs 'Background Details' do
      f.input :location, as: :select, collection: Background.locations.map {|k, v| [k.humanize, v]}
    end

    f.inputs 'Sections' do
      f.input :section_1, as: :trumbowyg, input_html: PASS_DIV
      f.input :logged_in_header, as: :trumbowyg, input_html: PASS_DIV
      f.input :section_2, as: :trumbowyg, input_html: PASS_DIV
      f.input :section_3, as: :trumbowyg, input_html: PASS_DIV
      f.input :section_4, as: :trumbowyg, input_html: PASS_DIV
    end

    f.inputs 'Metadata' do
      f.input :title
      f.input :description
    end

    f.actions
  end
end
