
#
# conf =
#   host: 10.10.1.1
#   subscriptions: []
#

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
    self.fetch(topic.split('/')[0])(topic, message)

  return this

MqttHandler::fetch = (topic) ->
  return this.handlers[topic] if this.handlers[topic]?
  return this.handlers['default']

MqttHandler::register = (topic, fn) ->
  this.handlers[topic] = fn

module.exports = MqttHandler
