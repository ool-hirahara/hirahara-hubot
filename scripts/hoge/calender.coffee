module.exports = (robot) ->
  cal = ->
    title = yield 'Creating a schedule. \nWhat?'
    attendees = yield 'With whom?'
    date = yield 'When?'
    while date == 'sat' or date == 'sun'
      date = yield 'No meeting on weekend. When?'
    place = yield 'Where?'

    delete robot.cal
    'Set ' + title + ' with ' + attendees+ ' on ' + date + ' at ' + place  + '. Enjoy!'

  next_value = (input) ->
    robot.cal.next(input).value

  # respond block
  robot.respond /cal$/i, (msg) ->
    robot.ignore_input = true
    robot.cal = cal()
    msg.send(next_value())

  # hear block
  robot.hear /(.*)\s*$/i, (msg) ->
    if !('cal' of robot and robot.cal)
      return
    if 'ignore_input' of robot and robot.ignore_input
      delete robot.ignore_input
      return
    msg.send(next_value msg.match[1])


