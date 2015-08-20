module ApplicationHelper
  def hidden_auth_token
    <<-HTML.html_safe
      <input type="hidden"
             name="authenticity_token"
             value="#{form_authenticity_token}">
    HTML
  end

  def list_of_linked_albums_for_band(band)
    album_links = band.albums.map do |album|
      "<a href=\"#{album_url(album)}\">#{h(album.name)}</a>"
    end
    album_links.join(", ").html_safe
  end
end
