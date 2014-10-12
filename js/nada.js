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

    Box.prototype.sansMargins = function() {
      return {
        height: this.height - (this.height * .2),
        width: this.width - (this.width * .2)
      };
    };

    Box.prototype.lineHeight = function() {
      return this.height;
    };

    return Box;

  })();

  Skin = (function() {
    function Skin() {}

    Skin.prototype.reject = function() {
      return $('.nada').remove();
    };

    Skin.prototype.inject = function() {
      var fontElement, head, styleElement;
      head = document.getElementsByTagName('head')[0];
      fontElement = this.fontElement();
      styleElement = this.styleElement();
      head.appendChild(fontElement);
      return head.appendChild(styleElement);
    };

    Skin.prototype.fontElement = function() {
      var element;
      element = document.createElement('link');
      return this.fontConfig(element);
    };

    Skin.prototype.styleElement = function() {
      var element;
      element = document.createElement('link');
      return this.styleConfig(element);
    };

    Skin.prototype.fontConfig = function(elem) {
      elem["class"] = 'nada';
      elem.href = 'http://fonts.googleapis.com/css?family=Didact+Gothic';
      elem.rel = 'stylesheet';
      elem.type = 'text/css';
      return elem;
    };

    Skin.prototype.styleConfig = function(elem) {
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
      var quotient;
      if (this.box.orientation === "portrait" || this.box.orientation === "square") {
        quotient = this.text.length / 2;
        return this.box.sansMargins().width / quotient;
      } else if (this.box.orientation === "landscape") {
        quotient = this.text.length / 4;
        return this.box.sansMargins().height / quotient;
      }
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
      var body, theyframe;
      body = document.getElementsByTagName('body')[0];
      theyframe = this.theyframe();
      console.log(theyframe);
      return body.appendChild(theyframe);
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
      elem.innerHTML = this.message.text;
      elem.style["font-size"] = "" + (this.message.fontSize()) + "px";
      elem.style["line-height"] = "" + (this.box.lineHeight()) + "px";
      return elem;
    };

    Truth.prototype.truthConfig = function(elem) {
      elem["class"] = "" + (this.matchingClass());
      elem.style.height = "" + this.box.height + "px";
      elem.style.width = "" + this.box.width + "px";
      elem.style.left = "" + (this.box.left - 10) + "px";
      elem.style.top = "" + (this.box.top - 10) + "px";
      return elem;
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

    Mask.prototype.hide = function() {
      return this.element.style.visibility = "hidden";
    };

    Mask.prototype.show = function() {
      return this.element.style.visibility = "visible";
    };

    return Mask;

  })();

  Glasses = (function() {
    function Glasses() {
      this.skin = new Skin;
    }

    Glasses.prototype.toggle = function() {
      if (this.on) {
        return this.takeOff();
      } else {
        return this.putOn();
      }
    };

    Glasses.prototype.putOn = function() {
      this.findMasks();
      this.hideLies();
      this.showTruths();
      return this.on = true;
    };

    Glasses.prototype.takeOff = function() {
      this.restoreLies();
      this.removeTruth();
      this.skin.reject();
      return this.on = false;
    };

    Glasses.prototype.findMasks = function() {
      var mask, masks;
      masks = document.getElementsByTagName('img');
      return this.masks = (function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = masks.length; _i < _len; _i++) {
          mask = masks[_i];
          console.log(mask);
          _results.push(new Mask(mask));
        }
        return _results;
      })();
    };

    Glasses.prototype.restoreLies = function() {
      var mask, _i, _len, _ref, _results;
      _ref = this.masks;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        mask = _ref[_i];
        console.log(mask);
        _results.push(mask.show());
      }
      return _results;
    };

    Glasses.prototype.hideLies = function() {
      var mask, _i, _len, _ref, _results;
      _ref = this.masks;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        mask = _ref[_i];
        _results.push(mask.hide());
      }
      return _results;
    };

    Glasses.prototype.showTruths = function() {
      this.skin.inject();
      return this.truths = this.masks.map(function(mask) {
        var truth;
        truth = new Truth(mask);
        truth.reveal();
        return truth;
      });
    };

    Glasses.prototype.removeTruth = function() {
      var theyframe;
      return theyframe = document.findElementsByTagName('theyframe');
    };

    return Glasses;

  })();

  this.g = new Glasses;

  this.g.toggle();

}).call(this);

//# sourceMappingURL=nada.js.map
