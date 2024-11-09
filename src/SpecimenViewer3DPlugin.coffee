class SpecimenViewer3DPlugin extends AssetDetail
  __resolveAssetInfo: (asset) ->
    # the object that will contain the 3d asset info.
    assetInfo = {
      type: null
      url: null
      extension: null
      defaults: ''
      asset: null
    }

    if not asset
      return assetInfo

    if asset instanceof Asset
      # if asset is instance of the class Asset
      # then we can get all the data about the versions of the file
      # with getSiblingsFromData()
      versions = asset.getSiblingsFromData()
    else
      # if asset is not instance of Asset
      # then can be data about the asset retrieved by createMarkup()
      versions = Object.values(asset)

    if not versions
      return assetInfo

    # we iterate the versions of the asset searching a valid 3dModel.
    for version in versions
      supported_extensions_types = {
        gltf: "gltf",
        glb: "gltf",
        stl: "stl"
        obj: "obj"
        p3v: "p3v"
      }

      # Nahima does not respect the actual extension from the filename
      # -> let's detect them ourselves, as otherwise,
      # our custom zip files will not be handled appropriately.
      extension = version.original_filename.split(".").pop()
      supported = false
      
      # iterate the supported extensions, set the asset info if applicable
      if supported_extensions_types[version.extension]
        assetInfo.type = supported_extensions_types[version.extension]
        supported = true
      if supported_extensions_types[extension]
        assetInfo.type = supported_extensions_types[extension]
        supported = true
      
      if supported
        assetInfo.asset = asset
        if typeof version.versions.original?.url != 'undefined'
          assetInfo.url = version.versions.original?.url
          assetInfo.extension = version.versions.original?.extension
        console.log("Found supported asset", [extension, supported, assetInfo, version, asset])
        break
        
    return assetInfo


  getButtonLocaKey: (asset) ->
    assetInfo = @__resolveAssetInfo(asset)
    if not assetInfo.url and not assetInfo.type
      return

    return "specimenviewer.asset.detail.button"

  startAutomatically: ->
    true

  # asset plugin method: called by the asset browser to create the html of the viewer.
  createMarkup: ->
    super()
    # we get the info of the asset, url and type
    assetInfo = @__resolveAssetInfo(@asset)
    if not assetInfo.url and assetInfo.type
      # if we have a type but no url we need to fetch the url from the server using the EAS api
      # this could happen when we get a asset from a linked object standard for example, in that
      # case the server will not send the versions of the asset by default,
      # we have to get it manually.
      ez5.api.eas({
        type: "GET",
        data: {
          ids: JSON.stringify([@asset.value._id]),
          format: "long"
        }
      }).done (assetServerData) =>
        # this call is async so we have to wait the response and then with the data
        # call to __createMarkup
        if assetServerData.error
          return
        @__createMarkup(null, assetServerData)

    # if we have the url we can create the html.
    if assetInfo.url
      @__createMarkup(assetInfo)

    return

  # this private method is used to be able to call async the create markup behaviour.
  __createMarkup: (assetInfo, assetServerData) ->
    # if we have serverData we get the asset info using __resolveAssetInfo()
    if not assetInfo and assetServerData
      assetInfo = @__resolveAssetInfo(assetServerData)
      if not assetInfo or not assetInfo.url or not assetInfo.type
        return

    viewerDiv = CUI.dom.element("div", {
      id: "specimen-3d-viewer"
    })
    plugin = ez5.pluginManager.getPlugin("easydb-3d-specimen-viewer-plugin")
    pluginStaticUrl = plugin.getBaseURL()

    frameSrc = pluginStaticUrl + "/build/index.html?type=" + assetInfo.type + "&asset=" + assetInfo.url
    # we could use assetInfo to conditionally change what viewer we use...
    # in particular, we need to return a different file for the photogrammetry viewer
    # to improve Firefox support
    # if assertInfo.type == "p3v" and assetInfo.version
    #   # in this file, look for the required components
    #   src2D = ""
    #   src3D = ""
    #   srcXml = ""

    #   # find them in the asset metadata
    #   asset = assetInfo.asset
    #   if !(asset instanceof Asset)
    #     asset = Object.values(asset)[0]
    #   if (asset instanceof Asset && asset.files)
    #     for file of asset.files
    #       if file.path.endswith(".xml")
    #         srcXml = assetInfo.url + "/" + file
    #       if file.path.endswith(".glb") || file.endswith(".gltf")
    #         src3D = file
    #       if file.path.contains("edof")
    #         src2D = file
    #     if (src2D && src3D && srcXml)
    #       frameSrc = pluginStaticUrl + "/build/photogrammetry_viewer.html?srcScanInformation=" +srcXml + "&src3D=" + src3D + "&src2D=" + src2D
        

    # ...but for now, we have one that supports all types anyway.
    iframe = CUI.dom.element("iframe", {
      id: "specimen-3d-viewer-iframe",
      "frameborder": "0",
      "scrolling": "no",
      "src": frameSrc
    })

    viewerDiv.appendChild(iframe)
    CUI.dom.append(@outerDiv, viewerDiv)


ez5.session_ready =>
  AssetBrowser.plugins.registerPlugin(SpecimenViewer3DPlugin)
  ez5.pluginManager.getPlugin("easydb-3d-specimen-viewer-plugin").loadCss()
