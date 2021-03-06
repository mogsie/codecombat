RootView = require 'views/core/RootView'
template = require 'templates/admin/design-elements-view'

module.exports = class DesignElementsView extends RootView
  id: 'design-elements-view'
  template: template
  
  afterInsert: ->
    super()
    # hack to get hash links to work. Make this general?
    hash = document.location.hash
    document.location.hash = ''
    setTimeout((-> document.location.hash = hash), 10)
    @$('#modal-2').find('.background-wrapper').addClass('plain')
    if hash is '#tooltips'
      setTimeout((=> @$('#tooltip').tooltip('show')), 20)
    if hash is '#popovers'
      setTimeout((=> @$('#popover').popover('show')), 20)
    tags = [
      "ActionScript",
      "AppleScript",
      "Asp",
      "BASIC",
      "C",
      "C++",
      "Clojure",
      "COBOL",
      "ColdFusion",
      "Erlang",
      "Fortran",
      "Groovy",
      "Haskell",
      "Java",
      "JavaScript",
      "Lisp",
      "Perl",
      "PHP",
      "Python",
      "Ruby",
      "Scala",
      "Scheme"
    ]
    @$('#tags').autocomplete({source: tags})
    if hash is '#autocomplete'
      setTimeout((=> @$('#tags').autocomplete("search", "t")), 20)
    @$('#slider-example').slider()