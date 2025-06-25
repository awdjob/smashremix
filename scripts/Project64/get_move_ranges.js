// This script is intended to be used with Project 64
// This prints and generates a json file with move ranges
// to be used when configuring AI.
// Add this to yout Project64 build and update the variables below.
// Use it in training mode, always facing right.
// The "Relative" range is supposed to be used mostly for aerials,
// since otherwise gravity and air drift would affect the numbers.
// Use the "Absolute" value for most moves.

// Must be updated with Character.action_string.table address from logfile.log
var characterActionStringTable = 0x804980F0;

// Must be updated with Action.shared_action_string_table address from logfile.log
var sharedStringTable = 0x80402888;

console.log("Script start");

var ranges = {};

var hitbox_addrs = [0x294, 0x358, 0x41c, 0x4e0];

// 0x0 = state // 0 = disabled, 1 = new hitbox, 2 and 3 = interpolate/copy current position to previous
// 0x24 size
// 0x44, 0x48, 0x4C

// 0x0078 = player pos vector address

var lastAction = -1;
var actionStartX = -1;
var actionStartY = -1;
var frameStart = -1;
var frameEnd = -1;
var frameCounter = 1;
var minx = Infinity;
var maxx = -Infinity;
var miny = Infinity;
var maxy = -Infinity;

var relativeminx = Infinity;
var relativemaxx = -Infinity;
var relativeminy = Infinity;
var relativemaxy = -Infinity;

if (typeof PJ64_JSAPI_VERSION == "undefined") {
  console.log(
    "This script is made to be used with the new script API ((Project64 4.0+). Please update your emulator."
  );
} else {
  // end of 0x8000a5e4
  events.onexec(0x8000a6d8, function (e) {
    var fd = fs.open("ranges.txt", "wb");
    var pAddr = 0x800466fc;
    var pObject = mem.u32[pAddr];
    var pStruct = mem.u32[pObject + 0x84];

    for (var i = 0; i < 1; i++) {
      var action = mem.u32[pStruct + 0x24];
      var playerPos = mem.u32[pStruct + 0x78];

      var playerX = mem.f32[playerPos];
      var playerY = mem.f32[playerPos + 0x4];

      if (action != lastAction) {
        var actionName = lastAction.hex();

        if (lastAction != -1) {
          if (lastAction < 0x00dc) {
            var actionPos = lastAction << 2;

            actionName = mem.getstring(mem.u32[sharedStringTable + actionPos]);
          } else {
            var charId = mem.u32[pStruct + 0x0008];

            var tablePos = mem.u32[characterActionStringTable + (charId << 2)];
            var stringPos = tablePos + ((lastAction - 0x00dc) << 2);

            if (stringPos != 0) {
              var nameString = mem.u32[stringPos];

              if (nameString) actionName = mem.getstring(nameString);
            }
          }
        }

        if (maxx > -Infinity) {
          console.log(
            "== " +
              actionName +
              " (" +
              lastAction.hex() +
              ") ==" +
              "\nframeStart: " +
              frameStart +
              "\nframeEnd: " +
              frameEnd +
              "\nabsolute: " +
              [minx, maxx, miny, maxy].join(", ") +
              "\nrelative: " +
              [relativeminx, relativemaxx, relativeminy, relativemaxy].join(
                ", "
              ) +
              "\n=========="
          );
          ranges[actionName] = {
            frameStart: frameStart,
            frameEnd: frameEnd,
            absolute: [minx, maxx, miny, maxy],
            relative: [relativeminx, relativemaxx, relativeminy, relativemaxy],
          };
        }

        minx = Infinity;
        maxx = -Infinity;
        miny = Infinity;
        maxy = -Infinity;
        relativeminx = Infinity;
        relativemaxx = -Infinity;
        relativeminy = Infinity;
        relativemaxy = -Infinity;
        lastAction = action;

        frameCounter = 1;
        frameStart = -1;
        frameEnd = -1;

        actionStartX = playerX;
        actionStartY = playerY;
      }

      for (var j = 0; j < 4; j++) {
        var hitbox_addr = pStruct + hitbox_addrs[j];

        var active = mem.u32[hitbox_addr];

        if (active) {
          if (frameStart == -1) frameStart = frameCounter;
          frameEnd = frameCounter;

          // console.log("got hitbox", j, hitbox_addr.hex());
          var x = mem.f32[hitbox_addr + 0x44];
          var y = mem.f32[hitbox_addr + 0x48];
          var size = mem.f32[hitbox_addr + 0x24];

          relativemaxx = Math.max(
            x + size / 2.0 - playerX,
            relativemaxx
          ).toFixed(0);
          relativeminx = Math.min(
            x - size / 2.0 - playerX,
            relativeminx
          ).toFixed(0);
          relativemaxy = Math.max(
            y + size / 2.0 - playerY,
            relativemaxy
          ).toFixed(0);
          relativeminy = Math.min(
            y - size / 2.0 - playerY,
            relativeminy
          ).toFixed(0);

          x -= actionStartX;
          y -= actionStartY;

          maxx = Math.max(x + size / 2.0, maxx).toFixed(0);
          minx = Math.min(x - size / 2.0, minx).toFixed(0);
          maxy = Math.max(y + size / 2.0, maxy).toFixed(0);
          miny = Math.min(y - size / 2.0, miny).toFixed(0);
        }
      }

      frameCounter += 1;

      // var nextObjPos = mem.u32[pStruct];
      // if (nextObjPos != 0x0) {
      //   pStruct = nextObjPos;
      // } else {
      //   break;
      // }
    }

    fs.write(fd, JSON.stringify(ranges, null, 2));
    fs.close(fd);
  });
}
