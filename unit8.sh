#!/bin/bash

# GAMEPLAY:
# Asteroids are hurtling toward your fine space ship!
# Move up and down with W and S to avoid them
# 
# That's all folks, the rest is all dev notes

# We're going to try make a galaga-esque thing
# Side-scrolling, asteroid shooting game
#
# Asteroids can come in a variety of sizes, each
# bullet will only break one bullet's-worh off.
#
# Ship only has a limited fire rate, so bigger,
# more frequent asteroids pose a challenge.
# Maybe have pickups to boost fire rate? Or add
# a bigger cannon?
#
# Use ticks to track time. Each three ticks or
# so the asteroids will progress, each tick the
# ship can move. Makes it seem like it's not a
# slideshow.
#
# Use vertical arrays to hold the game, shift
# left to make stuff move and check if anything
# is going to collide - take action
# Asteroids will be easier to gen this way, only
# need to make a 'spawn queue' which will place
# them on the end column until their length is
# complete. They will naturally progress to the
# left.
#
# Character type index:
#  > Ship part
#  : Ship part
#  = Ship part
#  - Bullet
#  # Asteroid
#
# ###
# ###
# ###                      ########
#                          ########
# =:> -   -   -   -   -    ########
#                          ########
#       ###############
#       ###############
#       ###############
#       ###############

#      []== -  -  -
#  -=E:[]]]]]>
#      []== -  -  -

##### BEGIN GLOBAL VARS ########################################################

# Set the game dimensions
height=20
width=100

# Set some character types
ship_head=">"
ship_engine=":"
ship_exhaust="="
bullet="-"
asteroid="#"
space=" " # haha, get it?

# Define a ship position
ship_y=10

##### BEGIN PRE-FLIGHT CHECKS ##################################################

# Spit out an error if the terminal height or width are too small
if [ $(tput lines) -lt $height ] || [ $(tput cols) -lt $width ]; then
    echo "Your terminal height is too small, must be at least "$width"x"$height # I wanted something like '100x25' so the weird quotes will have to do
    exit 1
fi

##### BEGIN FUNCTIONS ##########################################################

# Generates an asteroid and adds it to the queue
function generate_asteroid {
    local diameter=$()
}

# Scrolls the scene left by one, applying cell state changes as needed
function sidescroll {
    # Iterate over the grid
    for ((y=0; y < height; y++)); do
        for ((x = width - 1; x >= 0; x--)); do
            # Get an alias for the current cell
            local cell=${grid[$x,$y]}

            # Check if we are on the last column
            if [ $x -eq $width ]; then
                # Can we pull from the queue?
                # TODO: queue-pulling stuff
                yee=eet
            else
                # Get the cell on our right before we do anything
                local rcell=${grid[$((x+1)),$y]}

                # Check the next cell type
                if [ "$rcell" == "$asteroid" ]; then # If it's an asteroid...
                    # Depending on our current cell, decide what to do
                    case $cell in
                        $ship_head)
                            # About to crash
                            ship_crash
                            ;;
                        $bullet)
                            # Destroy the asteroid
                            ${grid[$x,$y]}=$space
                            ;;
                        $space)
                            # Move the asteroid over
                            ${grid[$x,$y]}=$asteroid
                            ;;
                    esac
                elif [ "$rcell" == "$space" ]; then # Otherwise, if it's space...
                    # Make sure we aren't a ship part first
                    if [ ! "$cell" == "$ship_head" ]; then
                        # Set the current cell to space
                        grid[$x,$y]=$space
                    fi
                fi
            fi
        done
    done
}

# Adds the ship to the grid
function add_ship {
    grid[0,$ship_y]=$ship_exhaust
    grid[1,$ship_y]=$ship_engine
    grid[2,$ship_y]=$ship_head
}

# Changes the ship's Y value by one in either direction
# PARAMS:
#  <up/down> - Direction to move the ship
function move_ship {
    # Get the direction parameter and lowercase it
    local direction=${1,,}

    # Check the direction the ship will move
    if [ "$direction" == "up" ] && [ $(can_move "$direction") == "y" ]; then # Moving up...
        # Clear the ship from the current position
        grid[0,$ship_y]=$space
        grid[1,$ship_y]=$space
        grid[2,$ship_y]=$space

        # Decrement ship Y
        ship_y=$(($ship_y - 1))

        # Add the ship in the desired direction
        grid[0,$ship_y]=$ship_exhaust
        grid[1,$ship_y]=$ship_engine
        grid[2,$ship_y]=$ship_head
    elif [ "$direction" == "down" ] && [ $(can_move "$direction") == "y" ]; then # Moving down...
        # Clear the ship from the current position
        grid[0,$ship_y]=$space
        grid[1,$ship_y]=$space
        grid[2,$ship_y]=$space

        # Increment ship Y
        ship_y=$(($ship_y + 1))

        # Add the ship in the desired direction
        grid[0,$ship_y]=$ship_exhaust
        grid[1,$ship_y]=$ship_engine
        grid[2,$ship_y]=$ship_head
    fi
}

# Checks if the ship can move in a direction
# PARAMS:
#  <up/down> - Direction to check
# RETURNS:
#  <y/n> - Whether the ship can move in that direction
function can_move {
    # Get the direction parameter and lowercase it
    local direction=${1,,}

    # Check the direction the ship will move
    if [ "$direction" == "up" ]; then
        # Make sure we haven't hit the top of the terminal
        if [ $ship_y -eq 0 ]; then
            # Return that the ship cannot move up
            echo "n"
            return 1
        fi

        # Set the Y offset in the direction we are checking
        # Saves a few lines
        local y_offset=-1
    elif [ "$direction" == "down" ]; then
        # Make sure we haven't hit the bottom of the terminal
        if [ $((ship_y + 1)) -eq $height ]; then
            # Return that the ship cannot move down
            echo "n"
            return 1
        fi

        # Set the Y offset in the direction we are checking
        # Saves a few lines
        local y_offset=1
    fi

    # Get the cells we're checking as a string for easy comparison
    local target_cells=${grid[0,$((ship_y + y_offset))]}${grid[1,$((ship_y + y_offset))]}${grid[2,$((ship_y + y_offset))]}

    # Check if the space contains asteroid
    if [ "$target_cells" == *"$asteroid"* ]; then
        # Return that the ship cannot move
        echo "n"
        return 1
    else
        # The space is unoccupied, return that the ship can move
        echo "y"
        return 0
    fi
}

# Draws the game grid to the terminal
function draw_grid {
    # Set the cursor position to the top left
    # I *could* use ANSI codes but this is much easier to read
    tput cup 0 0

    # Initialise an output variable for later
    local output=""

    # Iterate over the grid
    for ((y=0; y < height; y++)); do
        for ((x=0; x < width; x++)); do
            # Write the character without a newline
            output="$output${grid[$x,$y]}"
        done
        # Write a newline before we start the next row
        output="$output\n"
    done

    # Print out the grid
    echo -e "$output"
}

##### BEGIN MAIN LOGIC #########################################################

# Create the game grid
# We'll be using an associative array as a hack for multi-dimensional arrays
# See https://stackoverflow.com/a/16487733/5189708
# Accessing is as simple as ${grid[x,y]}
declare -A grid

# Initialise the grid to $space
for ((y=0; y < height; y++)); do
    for ((x=0; x < width; x++)); do
        grid[$x,$y]=$space
    done
done

# Clear the terminal
clear

# Apply the ship to the grid
# This should only have to happen once at the start of the game
add_ship

# Main game loop
while true; do
    # Run on a 4-tick cycle
    # The ship can move each tick
    # The map will progress each cycle
    # This is for ship input to feel more responsive
    for ((i=0; i < 10; i++)); do
        # Wait for a moment
        sleep 0.05

        # Read in any key presses
        read -rs -n 1 -t 0.001 key

        # Move the ship if there was a key pressed
        case $key in
            [Ww])
            move_ship up # Move up
            ;;
            [Ss])
            move_ship down # Move down
            ;;
        esac

        # Check if this is the first tick of the cycle
        if [ $i -eq 0 ]; then
            # Progress the map
            sidescroll
        fi

        # Draw the grid
        draw_grid
    done

done
