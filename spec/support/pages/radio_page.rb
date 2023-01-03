class RadioPage < SitePrism::Page
  set_url("/radio{/caregory}{/slug}")

  section :radio, "#inside-page" do
    element :title, "#inside-page>.title"
    element :description, "#inside-page>.description"
  end
end
