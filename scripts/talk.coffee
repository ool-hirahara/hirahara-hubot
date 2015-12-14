# Description:
#   Utility commands surrounding Hubot uptime.
#
# Commands:
#   hubot ping - Reply with pong
#   hubot echo <text> - Reply back with <text>
#   hubot time - Reply with current time
#   hubot die - End hubot process

urls = 'http://127.0.0.1/'

module.exports = (robot) ->
  robot.respond /おはよう$/i, (msg) ->
    msg.send msg.random ["おはよう", "おはー", "は？"]

module.exports = (robot) ->
  robot.respond /url test$/i, (msg) ->
    msg.send "#{urls}:8080/url_test"

