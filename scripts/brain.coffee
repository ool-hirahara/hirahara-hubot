#module.exports = (robot) ->
#  robot.hear /^(.+)\+\+$/i, (msg) ->
#    user = msg.match[1]
# 
#    if not robot.brain.data[user]
#      robot.brain.data[user] = 0
# 
#    robot.brain.data[user]++
#    robot.brain.save()
# 
#    msg.send robot.brain.data[user]

module.exports = (robot) ->
  robot.respond /nova server_name (.*)$/, (msg) ->
    message = msg.match[1]
    robot.brain.set 'nova_server_name', message
    msg.send "はいよ、サーバの名前は#{message}ってことで。"

  robot.respond /nova flavor_name (.*)$/, (msg) ->
    message = msg.match[1]
    robot.brain.set 'nova_flavor_name', message
    msg.send "flavor名は#{message}ね。覚えたよ。"

  robot.respond /nova image_name (.*)$/, (msg) ->
    message = msg.match[1]
    robot.brain.set 'nova_image_name', message
    msg.send "imageは#{message}を使う、っと。メモメモ。"

  robot.respond /nova network_name (.*)$/, (msg) ->
    message = msg.match[1]
    robot.brain.set 'nova_network_name', message
    msg.send "networkは#{message}ね。ふむふむ。"

  robot.respond /nova check$/, (msg) ->
    message = msg.match[1]
    brain_server_name = robot.brain.get('nova_server_name')
    brain_flavor_name = robot.brain.get('nova_flavor_name')
    brain_image_name = robot.brain.get('nova_image_name')
    brain_network_name = robot.brain.get('nova_network_name')
    msg.send "今覚えてるパラメータは、"
    msg.send "サーバは #{brain_server_name}"
    msg.send "フレーバーは #{brain_flavor_name}"
    msg.send "イメージは #{brain_image_name}"
    msg.send "ネットワークは #{brain_network_name}"
    msg.send "だよ！"

