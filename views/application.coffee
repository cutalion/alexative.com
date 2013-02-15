#
# Coderwall Badges
#

class CoderwallBadges
  constructor: (@name, @badges) ->

  renderBadges: ->
    @renderBadge(badge, @name) for badge in @badges

  renderBadge: (data, author_name) ->
    badge = new CoderwallBadgeModel(data)
    badge.set('author_name': author_name)
    view = new CodelwallBadgeView(model: badge)
    view.render()

CoderwallBadgeModel = Backbone.Model.extend({
  image_url: ->
    @get('badge')
})

CodelwallBadgeView = Backbone.View.extend({
  tagName: 'li',
  className: 'badge',
  template: _.template("""
      <a href=\"http://coderwall.com/<%= author_name %>\" target=\"_blank\" title="<%= description %>">&nbsp;</a>
      <h1><%= name %></h1>
  """),
  render: ->
    @$el.html(@template(@model.attributes))
    @$el.title = @model.description
    @$el.css('background-image', "url(#{@model.image_url()})")
    $('#coderwall_badges').append @$el
    return @
})

window.renderBadges = (response) ->
  coderwall = new CoderwallBadges(response.data.username, response.data.badges)
  coderwall.renderBadges()


#
# StackOverflow Badges
#

StackOverflowBadgesCollection = Backbone.Collection.extend({
  url: "https://api.stackexchange.com/2.1/users/376378/badges?order=asc&sort=rank&site=stackoverflow"
  parse: (response) ->
    response.items
})

StackOverflowBadgeView = Backbone.View.extend({
  tagName: 'li'

  className: ->
    "badge #{@model.get('rank')}"
  template: _.template("""
    <a href="<%= link %>" target="_blank" class="content">
      <span class="name"><%= name %></span>
      <br/>
      <span class="count"><%= award_count %></span>
    </a>
  """)

  render: ->
    @$el.html(@template(@model.attributes))
    return @
})


StackOverflowBadgesView = Backbone.View.extend({
  el: $('#stackoverflow_badges'),
  badges: new StackOverflowBadgesCollection,
  initialize: ->
    @listenTo(@badges, 'reset', @render)
    @badges.fetch()

  render: ->
    @badges.each @renderBadge, @

  renderBadge: (badge) ->
    view = new StackOverflowBadgeView(model: badge)
    el = view.render().$el
    @defferedShow el
    @$el.append el

  defferedShow: (el) ->
    el.css(opacity: 0)
    setTimeout (-> el.animate({opacity: 1}, 500, 'linear')), @showTime()

  showTime: ->
    difference = 250 # ms
    max = @badges.length * difference
    return Math.random() * max + difference
})



Zepto(($) ->
  new StackOverflowBadgesView
)

