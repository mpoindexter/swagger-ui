class MultiSignatureView extends Backbone.View
  events: {
  'change .signature-select'          : 'switchSignature'
  }

  initialize: ->
    @signatureElements = []

  render: ->
    template = @template()
    $(@el).html(template(@model))
    $('label[for=dataType]', $(@el)).text('Type')
    for typeModel in @model.typeModels
      @addTypeModel typeModel

    @switchSignature()

    @

  template: ->
      Handlebars.templates.multisignature

  switchSignature: (e) ->
    e?.preventDefault()
    for own key, value of @signatureElements
      $(value).hide()

    $(@signatureElements[$('.signature-select', $(@el)).val()]).show();
    @

  addTypeModel: (typeModel) ->
    signatureModel =
      sampleJSON: JSON.stringify(typeModel.createJSONSample(), null, 2)
      isParam: @model.isParam
      signature: typeModel.getMockSignature()

    signatureView = new SignatureView({model: signatureModel, tagName: 'div'})
    @signatureElements[typeModel.name] = signatureView.render().el
    $('.model-signatures', $(@el)).append @signatureElements[typeModel.name]
    @
