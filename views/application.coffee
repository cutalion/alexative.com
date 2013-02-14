class CoderwallBadges
  constructor: (@name, @badges) ->

  renderBadges: ->
    @renderBadge(badge, @name) for badge in @badges

  renderBadge: (badge, name) ->
    badge_element = @buildBadge(badge, name)
    badges = document.getElementById "badges"
    badges.appendChild(badge_element)

  buildBadge: (data, name) ->
    badge = document.createElement 'li'
    badge.innerHTML = """
      <a href=\"http://coderwall.com/#{name}\" target=\"_blank\" title="#{data.description}">&nbsp;</a>
      <h1>#{data.name}</h1>
    """
    badge.className = "badge"
    badge.title = data.description
    badge.style.backgroundImage = "url(#{data.badge})"
    badge


window.renderBadges = (response) ->
  coderwall = new CoderwallBadges(response.data.name, response.data.badges)
  coderwall.renderBadges()
