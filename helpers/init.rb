def title_case(string)
  string.gsub('_', ' ').titleize
end

def make_link(link_string)
  html = ''

  path = link_string.split('/')[-3..-1].join('/')
  name = File.basename(link_string.split('/')[-1], ".*")

  html += "<a href='/#{path}'>#{title_case(name)}</a>"
end
