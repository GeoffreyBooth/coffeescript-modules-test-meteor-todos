import { Meteor } from 'meteor/meteor'
import { Lists } from '../../api/lists/lists.coffee'
import { Todos } from '../../api/todos/todos.coffee'

# if the database is empty on server start, create some sample data.
Meteor.startup ->
  if Lists.find().count() is 0
    data = [
      {
        name: 'Meteor Principles'
        items: [
          'Data on the Wire'
          'One Language'
          'Database Everywhere'
          'Latency Compensation'
          'Full Stack Reactivity'
          'Embrace the Ecosystem'
          'Simplicity Equals Productivity'
        ]
      }
      {
        name: 'Languages'
        items: [
          'Lisp'
          'C'
          'C++'
          'Python'
          'Ruby'
          'JavaScript'
          'Scala'
          'Erlang'
          '6502 Assembly'
        ]
      }
      {
        name: 'Favorite Scientists'
        items: [
          'Ada Lovelace'
          'Grace Hopper'
          'Marie Curie'
          'Carl Friedrich Gauss'
          'Nikola Tesla'
          'Claude Shannon'
        ]
      }
    ]

    timestamp = (new Date).getTime()

    data.forEach (list) ->
      listId = Lists.insert
        name: list.name
        incompleteCount: list.items.length

      list.items.forEach (text) ->
        Todos.insert
          listId: listId
          text: text
          createdAt: new Date(timestamp)

        timestamp += 1 # ensure unique timestamp.
