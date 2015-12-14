# Description:
#   Use rest request
#
# Commands:
#   @slack_hubot wiki <text> - get "wikipedia/ + <text>" page body data
#   @slack_hubot cmd <text> - send command optional server and get command result
#   @slack_hubot XXX - now creating

request = require 'request'
rest_url = 'http://192.168.249.197'

module.exports = (robot) ->

  req_server_name = robot.brain.get('nova_server_name')
  req_flavor_name = robot.brain.get('nova_flavor_name')
  req_image_name = robot.brain.get('nova_image_name')
  req_network_name = robot.brain.get('nova_network_name')
  req_error_message = robot.brain.get('error_message')
  req_instance_id = robot.brain.get('instance_id')

# wikiのbodyを取ってくる。test用なのでイケてない
  robot.respond /wiki (.*)$/i, (msg) ->
    request
      url: 'http://ja.wikipedia.org/wiki/' + msg.match[1]
    , (err, response, body) ->
#      msg.send "body = " + body
      throw err if err  # 接続エラーなどが発生した場合
      if response.statusCode is 200  # ステータスコードが「OK」の場合
        msg.send body
        console.log body
      else
        console.log "response error: #{response.statusCode}"

# "cmd コマンド"で指定されたコマンドを実行する
# rm -rf でも通ってしまうので要注意！
  robot.respond /cmd (.*)$/i, (msg) ->
    request.post
      url: 'http://192.168.249.197:8000/cmd_op/'
      json:
        command: msg.match[1]
    , (err, response, body) ->
      throw err if err # 接続エラーなどが発生した場合
      if response.statusCode is 200  # ステータスコードが「OK」の場合
        for i in [0..body.command_result.length-1]
          msg.send "#{body.command_result[i]}"
        console.log body
      else
        console.log "response error: #{response.statusCode}"

# getでinfo系のリクエストを投げる
  robot.respond /op_get_info (.*)$/i, (msg) ->
    msg.send "#{msg.match[1]}情報ね。はいはい。"
    request.post
      url: 'http://192.168.249.197:8000/op_get_info/'
      json:
        node_type: msg.match[1]
    , (err, response, body) ->
      throw err if err  # 接続エラーなどが発生した場合
      if response.statusCode is 200  # ステータスコードが「OK」の場合
        for i in [0..body.servers.length-1]
#          msg.send "#{body.servers[i]}"
          msg.send JSON.stringify(body.servers[i])
        console.log body
      else
        console.log "response error: #{response.statusCode}"

# rest apiでnova createリクエストを投げる
  robot.respond /rest_api (.*)$/i, (msg) ->
    request.post
      url: 'http://192.168.249.197:8000/op_exec_create/'
      json:
        node_type: "nova"
        exec_type: "inst_create"
        sever_name: robot.brain.get('nova_server_name')
        network_name: robot.brain.get('nova_network_name')
        flavor_name: robot.brain.get('nova_flavor_name')
        image_name: robot.brain.get('nova_image_name')
    , (err, response, body) ->
      throw err if err  # 接続エラーなどが発生した場合
      if response.statusCode is 200  # ステータスコードが「OK」の場合
        for i in [0..body.servers.length-1]
#          msg.send "#{body.servers[i]}"
          msg.send JSON.stringify(body.servers[i])
        console.log body
      else
        console.log "response error: #{response.statusCode}"

# errorに反応してインスタンスIDを投げる
  robot.respond /[WARNING](.*)$/i, (msg) ->
    msg.send robot.brain.get('instance_id')
    request.post
      url: 'http://192.168.249.197:8000/yoshida_kun/'
      json:
        instance_id: robot.brain.get('instance_id')
        message1: robot.brain.get('error_message_1')
        message2: robot.brain.get('error_message_2')
    , (err, response, body) ->
      if robot.brain.get('instance_id')
        robot.brain.set 'instance_id', null
      throw err if err  # 接続エラーなどが発生した場合
      if response.statusCode is 200  # ステータスコードが「OK」の場合
#        for i in [0..body.servers.length-1]
#          msg.send "#{body.servers[i]}"
#          msg.send JSON.stringify(body.servers[i])
        msg.send JSON.stringify(body)
        console.log body
      else
        console.log "response error: #{response.statusCode}"

# インスタンスIDが入っているかを確認するためだけのrest
  robot.respond /instance check$/i, (msg) ->
    msg.send robot.brain.get('instance_id')
    request.post
      url: 'http://192.168.249.197:8000/yoshida_kun/'
      json:
        instance_id: robot.brain.get('instance_id')
        message: robot.brain.get('error_message')
    , (err, response, body) ->
      throw err if err  # 接続エラーなどが発生した場合
      if response.statusCode is 200  # ステータスコードが「OK」の場合
#        for i in [0..body.servers.length-1]
#          msg.send "#{body.servers[i]}"
#          msg.send JSON.stringify(body.servers[i])
        msg.send JSON.stringify(body)
        console.log body
      else
        console.log "response error: #{response.statusCode}"

