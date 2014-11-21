(function() {
  var Box, Glasses, Mask, Message, Skin, Truth;

  Box = (function() {
    function Box(height, width, left, top) {
      this.height = height;
      this.width = width;
      this.left = left;
      this.top = top;
      this.determineOrientation();
    }

    Box.prototype.determineOrientation = function() {
      if (this.height > this.width) {
        return this.orientation = 'portrait';
      } else if (this.width > this.height) {
        return this.orientation = 'landscape';
      } else {
        return this.orientation = 'square';
      }
    };

    Box.prototype.lineHeight = function() {
      return this.height;
    };

    return Box;

  })();

  Skin = (function() {
    function Skin() {}

    Skin.prototype.reject = function() {
      var link, match, skin, _i, _len, _ref, _results;
      _ref = ['http://fonts.googleapis.com/css?family=Didact+Gothic', chrome.extension.getURL("css/app.css")];
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        link = _ref[_i];
        match = this.findLink(link);
        if (match.length > 0) {
          skin = match[0];
          _results.push(skin.parentElement.removeChild(skin));
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    };

    Skin.prototype.inject = function() {
      this.injectHead();
      return this.injectContainer();
    };

    Skin.prototype.injectContainer = function() {
      var body, containerElement;
      body = document.getElementsByTagName('body')[0];
      containerElement = this.containerElement();
      return body.appendChild(containerElement);
    };

    Skin.prototype.injectHead = function() {
      var fontElement, head, styleElement;
      head = document.getElementsByTagName('head')[0];
      fontElement = this.fontElement();
      styleElement = this.styleElement();
      head.appendChild(fontElement);
      return head.appendChild(styleElement);
    };

    Skin.prototype.containerElement = function() {
      var containers;
      containers = document.getElementsByTagName('theycontainer');
      if (containers.length > 0) {
        this.element = containers[0];
      } else {
        this.element = document.createElement('theycontainer');
      }
      return this.element;
    };

    Skin.prototype.fontElement = function() {
      return this.findOrCreateLink(this.fontConfig(), 'http://fonts.googleapis.com/css?family=Didact+Gothic');
    };

    Skin.prototype.styleElement = function() {
      return this.findOrCreateLink(this.styleConfig(), chrome.extension.getURL("css/app.css"));
    };

    Skin.prototype.findOrCreateLink = function(config, link) {
      var element, matches;
      matches = this.findLink(link);
      element = null;
      if (matches.length > 0) {
        element = matches[0];
      } else {
        element = config;
      }
      return element;
    };

    Skin.prototype.findLink = function(link) {
      var element, elements, matches;
      elements = document.getElementsByTagName('link');
      matches = [];
      elements = (function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = elements.length; _i < _len; _i++) {
          element = elements[_i];
          if (element.href === link) {
            _results.push(matches.push(element));
          } else {
            _results.push(void 0);
          }
        }
        return _results;
      })();
      return matches;
    };

    Skin.prototype.fontConfig = function() {
      var elem;
      elem = document.createElement('link');
      elem["class"] = 'nada';
      elem.href = 'http://fonts.googleapis.com/css?family=Didact+Gothic';
      elem.rel = 'stylesheet';
      elem.type = 'text/css';
      return elem;
    };

    Skin.prototype.styleConfig = function() {
      var elem;
      elem = document.createElement('link');
      elem["class"] = 'nada';
      elem.rel = "stylesheet";
      elem.href = chrome.extension.getURL("css/app.css");
      elem.type = "text/css";
      elem.media = "all";
      return elem;
    };

    return Skin;

  })();

  Message = (function() {
    Message.TRUTH = ["OBEY", "SLEEP", "BUY", "LIKE", "SHARE", "CONSUME", "CONFORM", "SUBMIT", "REPRODUCE", "RETWEET", "MARRY AND REPRODUCE", "WORK 8 HOURS", "SLEEP 8 HOURS", "PLAY 8 HOURS", "WATCH YOUTUBE", "NO THOUGHT", "THIS IS YOUR GOD", "NO INDEPENDENT THOUGHT"];

    function Message(box) {
      this.box = box;
      this.text = Message.TRUTH[Math.floor(Math.random() * Message.TRUTH.length)];
    }

    Message.prototype.fontSize = function() {
      var fontSize, quotient;
      quotient = this.text.length / 1.3;
      return fontSize = this.box.width / quotient;
    };

    return Message;

  })();

  Truth = (function() {
    function Truth(mask) {
      this.mask = mask;
      this.buildBox();
      this.assignMessage();
    }

    Truth.prototype.reveal = function() {
      var container, theyframe;
      container = document.getElementsByTagName('theycontainer')[0];
      theyframe = this.theyframe();
      return container.appendChild(theyframe);
    };

    Truth.prototype.buildBox = function() {
      return this.box = new Box(this.mask.height, this.mask.width, this.mask.left, this.mask.top);
    };

    Truth.prototype.textContainer = function() {
      var element;
      element = document.createElement('truth');
      return this.textConfig(element);
    };

    Truth.prototype.theyframe = function() {
      var element, theyframe;
      element = document.createElement('theyframe');
      theyframe = this.truthConfig(element);
      theyframe.appendChild(this.textContainer());
      return theyframe;
    };

    Truth.prototype.assignMessage = function() {
      return this.message = new Message(this.box);
    };

    Truth.prototype.matchingClass = function() {
      return "" + this.message.text + "--" + (this.generateUUID());
    };

    Truth.prototype.textConfig = function(elem) {
      elem["class"] = "" + (this.matchingClass());
      elem.innerHTML = this.message.text;
      elem.style["font-size"] = "" + (this.message.fontSize()) + "px";
      elem.style["line-height"] = "" + (this.box.lineHeight()) + "px";
      return elem;
    };

    Truth.prototype.truthConfig = function(elem) {
      elem["class"] = "" + (this.matchingClass());
      elem.style.height = "" + this.box.height + "px";
      elem.style.width = "" + this.box.width + "px";
      elem.style.left = "" + this.box.left + "px";
      elem.style.top = "" + this.box.top + "px";
      elem.style.border = "solid " + (this.borderWidth()) + "px black";
      return elem;
    };

    Truth.prototype.borderWidth = function() {
      var borderWidth, borderwidth;
      borderWidth = this.box.width / 50;
      if (borderWidth > 4) {
        borderwidth = 4;
      } else if (borderWidth < 1) {
        borderWidth = 1;
      }
      return borderWidth;
    };

    Truth.prototype.generateUUID = function() {
      var d;
      if (this.uuid) {
        return this.uuid;
      }
      d = new Date().getTime();
      this.uuid = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx".replace(/[xy]/g, function(c) {
        var r;
        r = (d + Math.random() * 16) % 16 | 0;
        d = Math.floor(d / 16);
        return (c === "x" ? r : r & 0x7 | 0x8).toString(16);
      });
      return this.uuid;
    };

    return Truth;

  })();

  Mask = (function() {
    function Mask(element) {
      var rect;
      this.element = element;
      rect = this.element.getBoundingClientRect();
      this.height = rect.height;
      this.width = rect.width;
      this.left = rect.left;
      this.top = rect.top;
    }

    return Mask;

  })();

  Glasses = (function() {
    function Glasses() {
      this.skin = new Skin;
    }

    Glasses.prototype.toggle = function() {
      if (this.on()) {
        return this.takeOff();
      } else {
        return this.putOn();
      }
    };

    Glasses.prototype.putOn = function() {
      this.skin.inject();
      return this.showTruth();
    };

    Glasses.prototype.takeOff = function() {
      this.skin.reject();
      return this.removeTruth();
    };

    Glasses.prototype.removeTruth = function() {
      var container, _i, _len, _ref, _results;
      _ref = this.theyContainer();
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        container = _ref[_i];
        _results.push(container.parentElement.removeChild(container));
      }
      return _results;
    };

    Glasses.prototype.showTruth = function() {
      return this.truths = this.allMasks().map(function(mask) {
        var truth;
        truth = new Truth(mask);
        truth.reveal();
        return truth;
      });
    };

    Glasses.prototype.allMasks = function() {
      var mask, masks;
      masks = document.getElementsByTagName('img');
      return this.masks = (function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = masks.length; _i < _len; _i++) {
          mask = masks[_i];
          _results.push(new Mask(mask));
        }
        return _results;
      })();
    };

    Glasses.prototype.on = function() {
      if (this.theyContainer().length > 0) {
        return true;
      } else {
        return false;
      }
    };

    Glasses.prototype.theyContainer = function() {
      return document.getElementsByTagName('theycontainer');
    };

    return Glasses;

  })();

  if (!this.g) {
    this.g = new Glasses;
  }

  this.g.toggle();

}).call(this);

//# sourceMappingURL=nada.js.map
