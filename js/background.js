(function() {
  chrome.browserAction.onClicked.addListener(function(tab) {
    return chrome.tabs.executeScript(null, {
      file: "js/nada.js"
    });
  });

}).call(this);

//# sourceMappingURL=background.js.map
