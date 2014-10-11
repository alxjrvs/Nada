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
      $('head').after(this.font());
      return $('head').after(this.style());
    };

    Skin.prototype.font = function() {
      return $('<link />', this.fontConfig());
    };

    Skin.prototype.style = function() {
      return $('<link />', this.styleConfig());
    };

    Skin.prototype.fontConfig = function() {
      return {
        "class": 'nada',
        href: 'http://fonts.googleapis.com/css?family=Didact+Gothic',
        rel: 'stylesheet',
        type: 'text/css'
      };
    };

    Skin.prototype.styleConfig = function() {
      return {
        "class": 'nada',
        rel: "stylesheet",
        href: "./css/app.css",
        type: "text/css",
        media: "all"
      };
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
      return $('body').append(this.theyframe());
    };

    Truth.prototype.buildBox = function() {
      return this.box = new Box(this.mask.height, this.mask.width, this.mask.left, this.mask.top);
    };

    Truth.prototype.textContainer = function() {
      return $('<truth />', this.textConfig());
    };

    Truth.prototype.theyframe = function() {
      return $('<theyframe />', this.truthConfig()).append(this.textContainer());
    };

    Truth.prototype.assignMessage = function() {
      return this.message = new Message(this.box);
    };

    Truth.prototype.matchingClass = function() {
      return "" + this.message.text + "--" + (this.generateUUID());
    };

    Truth.prototype.textConfig = function() {
      return {
        text: this.message.text,
        "class": "" + this.box.orientation,
        css: {
          "font-size": "" + (this.message.fontSize()) + "px",
          "line-height": "" + (this.box.lineHeight()) + "px"
        }
      };
    };

    Truth.prototype.truthConfig = function() {
      return {
        "class": "" + (this.matchingClass()),
        css: {
          height: "" + this.box.height + "px",
          width: "" + this.box.width + "px",
          left: "" + (this.box.left - 10) + "px",
          top: "" + (this.box.top - 10) + "px"
        }
      };
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
      this.element = element;
      this.height = this.element.offsetHeight;
      this.width = this.element.offsetWidth;
      this.left = this.element.offsetLeft;
      this.top = this.element.offsetTop;
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

    Glasses.prototype.putOn = function() {
      this.findMasks();
      this.hideLies();
      return this.showTruths();
    };

    Glasses.prototype.takeOff = function() {
      this.restoreLies();
      this.removeTruth();
      return this.skin.reject();
    };

    Glasses.prototype.findMasks = function() {
      var mask, masks;
      masks = $('iframe');
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

    Glasses.prototype.restoreLies = function() {
      var mask, _i, _len, _ref, _results;
      _ref = this.masks;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        mask = _ref[_i];
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
      var truth, _i, _len, _ref, _results;
      this.assembleTruths();
      this.skin.inject();
      _ref = this.truths;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        truth = _ref[_i];
        _results.push(truth.reveal());
      }
      return _results;
    };

    Glasses.prototype.removeTruth = function() {
      return $('theyframe').remove();
    };

    Glasses.prototype.assembleTruths = function() {
      return this.truths = this.masks.map(function(mask) {
        return new Truth(mask);
      });
    };

    return Glasses;

  })();

  this.g = new Glasses;

  this.takeOffTheGlasses = function() {
    return this.g.takeOff();
  };

  this.putOnTheGlasses = function() {
    return this.g.putOn();
  };

}).call(this);

//# sourceMappingURL=nada.js.map
