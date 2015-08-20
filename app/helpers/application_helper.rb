module ApplicationHelper
  def hidden_auth_token
    <<-HTML.html_safe
      <input type="hidden"
             name="authenticity_token"
             value="#{form_authenticity_token}">
    HTML
  end

  def all_bands
    Band.all
  end

  def all_albums
    Album.all
  end

  def album_links_for_band(band)
    band.albums.map { |album| link(album) }
  end

  def track_links_for_album(album)
    album.tracks.map { |track| link(track) }
  end

  def link(item)
    url = case item
    when Album
      album_url(item)
    when Band
      band_url(item)
    when Track
      track_url(item)
    end

    "<a href=\"#{url}\">#{h(item.name)}</a>".html_safe
  end

  def ugly_lyrics(lyrics)
    lines = h(lyrics).split("\n")
    lines_with_notes = lines.map { |line| "&#9835; " + line }
    "<pre>#{lines_with_notes.join("\n")}</pre>".html_safe
  end
end
