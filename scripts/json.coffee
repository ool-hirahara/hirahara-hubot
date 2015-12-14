# Description:
#   test json request
#
# Commands:
#   @slack_hubot json test - response body as String convert from Object(JSON)

request = require 'request'

module.exports = (robot) ->
  robot.respond /json test/i, (msg) ->
    request.post
      json:
        data:'hoge'
      msg.send json

  robot.respond /parse test/i, (msg) ->
      teststr = "| a4f25e56-1d1b-4e45-918e-109b250d90cc | testinstanse | ACTIVE | -          | Running     | test-network=172.17.0.1 |\nhoge"
#      sendstr = parse_json.replace(/\n/g, "\\n")
#      msg.send sendstr
      msg.send teststr

