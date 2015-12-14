# Description:
#   Use rest request
#
# Commands:
#   @slack_hubot wiki <text> - get "wikipedia/ + <text>" page body data
#   @slack_hubot cmd <text> - send command optional server and get command result
#   @slack_hubot XXX - now creating

request = require 'request'

# エラーが発生したときに反応する
module.exports = (robot) ->

  robot.respond /(.*)WARNING(.*)$/, (msg) ->
    tmp_message = robot.brain.get('error_message_1')
    hoge = robot.brain.set 'error_message_2', tmp_message
    huga = robot.brain.set 'error_message_1', msg.match

  robot.respond /(.*)[instance: (.*)]$/, (msg) ->
    message = msg.match[1]
    instance_id_postion = message.indexOf('instance: ')
    instance_message = message[instance_id_postion+10..instance_id_postion+45]
    huga = robot.brain.set 'instance_id', instance_message

  robot.respond /delete messages$/, (msg) ->
    message = msg.match[1]
    hoge = robot.brain.set 'error_message_1', null
    hoga = robot.brain.set 'error_message_2', null
    huyo = robot.brain.set 'instance_id', null

  robot.respond /check err$/, (msg) ->
    msg.send robot.brain.get('error_message_1')
    msg.send robot.brain.get('error_message_2')
    msg.send robot.brain.get('instance_id')

