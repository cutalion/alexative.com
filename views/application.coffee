window.renderBadges = (response) ->
  console.log response
  renderBadge(badge, response.data.name) for badge in response.data.badges

window.renderBadge = (badge, name) ->
  badge_element = buildBadge(badge, name)
  badges = document.getElementById "badges"
  badges.appendChild(badge_element)

window.buildBadge = (data, name) ->
  badge = document.createElement 'li'
  badge.innerHTML = """
    <a href=\"http://coderwall.com/#{name}\" target=\"_blank\" title="#{data.description}">&nbsp;</a>
    <h1>#{data.name}</h1>
  """
  badge.className = "badge"
  badge.title = data.description
  badge.style.backgroundImage = "url(#{data.badge})"
  badge
