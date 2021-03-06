errors = require '../commons/errors'
_ = require 'lodash'
Promise = require 'bluebird'

module.exports =

  getLimitFromReq: (req, options) ->
    options = _.extend({
      max: 1000
      default: 100
    }, options)

    limit = options.default

    if req.query.limit
      limit = parseInt(req.query.limit)
      valid = tv4.validate(limit, {
        type: 'integer'
        maximum: options.max
        minimum: 1
      })
      if not valid
        throw new errors.UnprocessableEntity('Invalid limit parameter.')

    return limit


  getSkipFromReq: (req, options) ->
    options = _.extend({
      max: 1000000
      default: 0
    }, options)

    skip = options.default

    if req.query.skip
      skip = parseInt(req.query.skip)
      valid = tv4.validate(skip, {
        type: 'integer'
        maximum: options.max
        minimum: 0
      })
      if not valid
        throw new errors.UnprocessableEntity('Invalid sort parameter.')

    return skip


  getProjectFromReq: (req, options) ->
    options = _.extend({}, options)
    return null unless req.query.project
    projection = {}

    if req.query.project is 'true'
      projection = {original: 1, name: 1, version: 1, description: 1, slug: 1, kind: 1, created: 1, permissions: 1}
    else
      for field in req.query.project.split(',')
        projection[field] = 1

    return projection
