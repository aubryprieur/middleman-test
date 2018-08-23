activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end

activate :sprockets

page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
  activate :relative_assets
  set :relative_links, true
end

activate :deploy do |deploy|
  deploy.build_before = true
  deploy.deploy_method = :git
end

###
# Blog settings
###
Time.zone = "Paris"
I18n.config.enforce_available_locales = false

activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  # blog.prefix = "blog"
    blog.name = "blog"
    blog.permalink = "/{title}.html"
  # Matcher for blog source files
    blog.sources = "/blog/{year}-{month}-{day}-{title}.html"
  # blog.taglink = "tags/{tag}.html"
    blog.layout = "layouts/blog"
  # blog.summary_separator = /()/
  # blog.summary_length = 250
  # blog.year_link = "{year}.html"
  # blog.month_link = "{year}/{month}.html"
  # blog.day_link = "{year}/{month}/{day}.html"
    blog.default_extension = ".markdown"
    blog.new_article_template = "source/new-article.erb"

  # blog.tag_template = "tag.html"
  # blog.calendar_template = "calendar.html"

  # Enable pagination
    blog.paginate = true
    blog.per_page = 10
    blog.page_link = "/{num}"

  # Custom categories
    blog.custom_collections = {
      category: {
        link: '/categories/{category}.html',
        template: '/category.html'
      }
    }
end

page "/feed.xml", layout: false

# Methods defined in the helpers block are available in templates
helpers do
  def find_author(author_slug)
    author_slug = author_slug.downcase
    result = data.team.select {|member| member.keys.first == author_slug }
    raise ArgumentError unless result.any?
    result.first
  end
end


activate :disqus do |d|
  d.shortname = 'middleman-test' # Remplacer par votre nom Disqus
end
