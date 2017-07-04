# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://opensourcefriday.com"
SitemapGenerator::Sitemap.include_root = false

SitemapGenerator::Sitemap.create do
  def home_view_options(view)
    @home_views ||= Rails.root.join("app/views/home")
    view_lastmod = @home_views.join("#{view}.html.erb").mtime
    {
      priority: 1.0,
      changefreq: "weekly",
      lastmod: view_lastmod,
    }
  end

  add root_path, home_view_options(:index)
  add businesses_path, home_view_options(:businesses)
  add maintainers_path, home_view_options(:maintainers)
end
