" With the toboggan login problems resolved, you set off toward the airport.
" While travel by toboggan might be easy, it's certainly not safe:
" there's very minimal steering and the area is covered in trees.
" You'll need to see which angles will take you near the fewest trees.

" Due to the local geology, trees in this area only grow on exact integer coordinates in a grid.
" You make a map (your puzzle input) of the open squares (.) and trees (#) you can see. For example:

" ..##.......
" #...#...#..
" .#....#..#.
" ..#.#...#.#
" .#...##..#.
" ..#.##.....
" .#.#.#....#
" .#........#
" #.##...#...
" #...##....#
" .#..#...#.#

" These aren't the only trees, though;
" due to something you read about once involving arboreal genetics and biome stability,
" the same pattern repeats to the right many times:

" ..##.........##.........##.........##.........##.........##.......  --->
" #...#...#..#...#...#..#...#...#..#...#...#..#...#...#..#...#...#..
" .#....#..#..#....#..#..#....#..#..#....#..#..#....#..#..#....#..#.
" ..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#
" .#...##..#..#...##..#..#...##..#..#...##..#..#...##..#..#...##..#.
" ..#.##.......#.##.......#.##.......#.##.......#.##.......#.##.....  --->
" .#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#
" .#........#.#........#.#........#.#........#.#........#.#........#
" #.##...#...#.##...#...#.##...#...#.##...#...#.##...#...#.##...#...
" #...##....##...##....##...##....##...##....##...##....##...##....#
" .#..#...#.#.#..#...#.#.#..#...#.#.#..#...#.#.#..#...#.#.#..#...#.#  --->

" You start on the open square (.) in the top-left corner and need to reach the bottom
" (below the bottom-most row on your map).

" The toboggan can only follow a few specific slopes
" (you opted for a cheaper model that prefers rational numbers);
" start by counting all the trees you would encounter for the slope right 3, down 1:

" From your starting position at the top-left, check the position that is right 3 and down 1.
" Then, check the position that is right 3 and down 1 from there, and so on until you go past the bottom of the map.

" The locations you'd check in the above example are marked here with O where there was an open square
" and X where there was a tree:

" ..##.........##.........##.........##.........##.........##.......  --->
" #..O#...#..#...#...#..#...#...#..#...#...#..#...#...#..#...#...#..
" .#....X..#..#....#..#..#....#..#..#....#..#..#....#..#..#....#..#.
" ..#.#...#O#..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#
" .#...##..#..X...##..#..#...##..#..#...##..#..#...##..#..#...##..#.
" ..#.##.......#.X#.......#.##.......#.##.......#.##.......#.##.....  --->
" .#.#.#....#.#.#.#.O..#.#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#
" .#........#.#........X.#........#.#........#.#........#.#........#
" #.##...#...#.##...#...#.X#...#...#.##...#...#.##...#...#.##...#...
" #...##....##...##....##...#X....##...##....##...##....##...##....#
" .#..#...#.#.#..#...#.#.#..#...X.#.#..#...#.#.#..#...#.#.#..#...#.#  --->
" In this example, traversing the map using this slope would cause you to encounter 7 trees.

" Starting at the top-left corner of your map and following a slope of right 3 and down 1,
" how many trees would you encounter?

" Your puzzle answer was 184.

" Time to check the rest of the slopes - you need to minimize the probability of a sudden arboreal stop, after all.

" Determine the number of trees you would encounter if, for each of the following slopes,
" you start at the top-left corner and traverse the map all the way to the bottom:

" Right 1, down 1.
" Right 3, down 1. (This is the slope you already checked.)
" Right 5, down 1.
" Right 7, down 1.
" Right 1, down 2.
" In the above example, these slopes would find 2, 7, 3, 4, and 2 tree(s) respectively;
" multiplied together, these produce the answer 336.

" What do you get if you multiply together the number of trees encountered on each of the listed slopes?

" Your puzzle answer was 2431272960.

CLASS zcl_advent2020_day03_schmelto DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_advent2020_schmelto .

    METHODS part1
      IMPORTING
        !input        TYPE string
      RETURNING
        VALUE(output) TYPE string .
    METHODS part2
      IMPORTING
        !input        TYPE string
      RETURNING
        VALUE(output) TYPE string .

    METHODS counter
      IMPORTING
        !input      TYPE string
        !right      TYPE i
        !down       TYPE i
      RETURNING
        VALUE(count) TYPE i .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_advent2020_day03_schmelto IMPLEMENTATION.

  METHOD part1.

    output = counter(
      right  = 3
      input  = input
      down   = 1 ).
    CONDENSE output.

  ENDMETHOD.

  METHOD part2.

    DATA(result) = counter(
      input  = input
      right  = 1
      down   = 1 ).
    result = result * counter(
      input  = input
      right  = 3
      down   = 1 ).
    result = result * counter(
      input  = input
      right  = 5
      down   = 1 ).
    result = result * counter(
      input  = input
      right  = 7
      down   = 1 ).
    result = result * counter(
      input  = input
      right  = 1
      down   = 2 ).
    output = condense( result ).

  ENDMETHOD.

  METHOD counter.

    " trees table cannot be declared inline...
    DATA trees TYPE STANDARD TABLE OF string.
    DATA x TYPE i VALUE 0.
    DATA index TYPE i.

    SPLIT input AT |\r\n| INTO TABLE trees.

    READ TABLE trees INDEX 1 INTO DATA(str).
    ASSERT sy-subrc = 0.
    DATA(width) = strlen( str ).

    LOOP AT trees INTO str.
      index = index + 1.
      IF index > 1 AND down > 1 AND index MOD down = 0.
        CONTINUE.
      ENDIF.
      DATA(pos) = x MOD width.
      DATA(char) = str+pos(1).
      IF char = '#'.
        count = count + 1.
      ENDIF.
      x = x + right.
    ENDLOOP.

    ASSERT count > 0.

  ENDMETHOD.

  METHOD zif_advent2020_schmelto~solve.

    output = part2( input ).

  ENDMETHOD.
ENDCLASS.