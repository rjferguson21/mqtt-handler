_ = require 'lodash'
#
# conf =
#   subscriptions: []

matches = (needle, haystack) ->
  return haystack.indexOf(needle) > -1

MqttHandler = (conf, conn) ->
  self = this
  self.conf = conf
  self.client = conn

  self.handlers =
    default: (topic, message) ->
      console.log 'unable to find handler, using default for', topic, message.toString()

  self.client.on 'connect', ->
    self.client.subscribe conf.subscriptions

  self.client.on 'message', (topic, message) ->
    self.fetch(topic)
    .forEach (fn) ->
      fn(topic, message)

  return this

MqttHandler::fetch = (topic) ->
  self = this
  handlers = _.filter(_.keys(self.handlers), (pattern) ->
    return matches pattern, topic
  ).map (key) ->
    self.handlers[key]

  return handlers if handlers.length?
  return self.handlers['default']

MqttHandler::register = (topic, fn) ->
  this.handlers[topic] = fn

module.exports = MqttHandler
