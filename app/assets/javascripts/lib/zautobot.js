(function (root, factory) {
    if (typeof define === 'function' && define.amd) {
        // AMD. Register as an anonymous module.
        define(['moment'], factory);
    } else {
        // Browser globals
        root.autobots = factory(root.moment);
        // autobots = factory(moment);
    }
}(this, function (moment) {

    var autobots = {
        version: '0.1',
        autoher: 'Phoorichet'
    };

    /**
     * [parseDate description]
     * @param  {[String]} dateString [Date string]
     * @param  {[String]} dateType   [Either _relative or _static]
     * @return {[Array]}             [A pair of start and end time]
     */
    autobots.parseDate = function(dateString, dateType) {
        var now   = new Date(),
            result = {};

        switch(dateType){
            case "_relative":
                result.start = autobots.parseDateRelative(dateString);
                result.stop  = now;
            case "_realtime":
                result.start = autobots.parseDateRealtime(dateString);
                result.stop  = now;
                break;
            default:
                result;
        };

        return result;
    };

    autobots.parseDateRelative = function() {

    }

    /* This is a simplified version of elasticsearch's date parser */
    autobots.parseDateRealtime = function(text) {
        if(_.isDate(text)) {
          return text;
        }
        var time,
          mathString = "",
          index,
          parseString;
        if (text.substring(0,3) === "now") {
          time = new Date();
          mathString = text.substring("now".length);
        } else {
          index = text.indexOf("||");
          parseString;
          if (index === -1) {
            parseString = text;
            mathString = ""; // nothing else
          } else {
            parseString = text.substring(0, index);
            mathString = text.substring(index + 2);
          }
          // We're going to just require ISO8601 timestamps, k?
          time = new Date(parseString);
        }

        if (!mathString.length) {
          return time;
        }

        //return [time,parseString,mathString];
        return autobots.parseDateMath(mathString, time);   
    };

    autobots.parseDateMath = function(mathString, time, roundUp) {
        var dateTime = moment(time);
        for (var i = 0; i < mathString.length;) {
          var c = mathString.charAt(i++),
            type,
            num,
            unit;
          if (c === '/') {
            type = 0;
          } else if (c === '+') {
            type = 1;
          } else if (c === '-') {
            type = 2;
          } else {
            return false;
          }

          if (isNaN(mathString.charAt(i))) {
            num = 1;
          } else {
            var numFrom = i;
            while (!isNaN(mathString.charAt(i))) {
              i++;
            }
            num = parseInt(mathString.substring(numFrom, i),10);
          }
          if (type === 0) {
            // rounding is only allowed on whole numbers
            if (num !== 1) {
              return false;
            }
          }
          unit = mathString.charAt(i++);
          switch (unit) {
          case 'y':
            if (type === 0) {
              roundUp ? dateTime.endOf('year') : dateTime.startOf('year');
            } else if (type === 1) {
              dateTime.add('years',num);
            } else if (type === 2) {
              dateTime.subtract('years',num);
            }
            break;
          case 'M':
            if (type === 0) {
              roundUp ? dateTime.endOf('month') : dateTime.startOf('month');
            } else if (type === 1) {
              dateTime.add('months',num);
            } else if (type === 2) {
              dateTime.subtract('months',num);
            }
            break;
          case 'w':
            if (type === 0) {
              roundUp ? dateTime.endOf('week') : dateTime.startOf('week');
            } else if (type === 1) {
              dateTime.add('weeks',num);
            } else if (type === 2) {
              dateTime.subtract('weeks',num);
            }
            break;
          case 'd':
            if (type === 0) {
              roundUp ? dateTime.endOf('day') : dateTime.startOf('day');
            } else if (type === 1) {
              dateTime.add('days',num);
            } else if (type === 2) {
              dateTime.subtract('days',num);
            }
            break;
          case 'h':
          case 'H':
            if (type === 0) {
              roundUp ? dateTime.endOf('hour') : dateTime.startOf('hour');
            } else if (type === 1) {
              dateTime.add('hours',num);
            } else if (type === 2) {
              dateTime.subtract('hours',num);
            }
            break;
          case 'm':
            if (type === 0) {
              roundUp ? dateTime.endOf('minute') : dateTime.startOf('minute');
            } else if (type === 1) {
              dateTime.add('minutes',num);
            } else if (type === 2) {
              dateTime.subtract('minutes',num);
            }
            break;
          case 's':
            if (type === 0) {
              roundUp ? dateTime.endOf('second') : dateTime.startOf('second');
            } else if (type === 1) {
              dateTime.add('seconds',num);
            } else if (type === 2) {
              dateTime.subtract('seconds',num);
            }
            break;
          default:
            return false;
          }
        }
        return dateTime.toDate();
      };

    /**
     * Get relative time range from now.
     * Ex. now-1m, now-2h.
     *
     * Wrap kbn for now.
     * @param  {[type]} dateString [description]
     * @return {[type]}            [description]
     */
    function _parseRelative(dateString){

    };

    /**
     * Get static time range from the current date.
     * Ex. lastmonth, thismonth
     * @param  {[type]} dateString [description]
     * @return {[type]}            [description]
     */
    function _parseStatic(dateString){ 
        var m = moment(); // get the reference time

    };

    // Just return a value to define the module export.
    // This example returns an object, but the module
    // can return a function as the exported value.
    return autobots;
}));