#!/bin/bash

# GAMEPLAY:
# Asteroids are hurtling toward your fine space ship!
# Move up and down with 'W' and 'S' to avoid them
# Oh! You've also recently installed a plasma cannon you can fire with 'D'
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

# Generates an asteroid and adds it to the grid
function generate_asteroid {
    local radius=$(shuf -i 1-5 -n 1) # Get a radius between 1 and 5
    local centre=$(shuf -i 0-$height -n 1) # Get a random Y pos between 0 and $height

    # Make some boundary variables so I don't lose my mind trying to remember
    # what all of these calculations are
    local left=$((width-centre-radius))
    local right=$width
    local top=$((centre-radius))
    local bottom=$((centre+radius))

    # Clamp top and bottom
    if [ $top -lt 0 ]; then top=0; fi
    if [ $bottom -gt $((height-1)) ]; then bottom=$((height-1)); fi

    for ((y = top; y <= bottom; y++)); do
        for ((x = left; x < right; x++)); do
            grid[$x,$y]=$asteroid
        done
    done
}

# Checks for any collisions between the bullet and game grid and applies changes
function apply_bullets {
    for ((y = 0; y < height; y++)); do
        for ((x = 0; x < width; x++)); do
            # Check if there are overlapping bullets and asteroids
            if [ "${bullet_grid[$x,$y]}" == "$bullet" ] && [ "${grid[$x,$y]}" == "$asteroid" ]; then
                # Delete both the bullet and asteroid
                grid[$x,$y]=$space
                bullet_grid[$x,$y]=$space
            fi
        done
    done
}

# Scrolls the scene left by one, applying cell state changes as needed
# This only modifies the grid, drawing is handled by another function
function sidescroll {
    # Move all the bullets right one
    for ((y = 0; y < height; y++)); do
        for ((x = width; x >= 0; x--)); do
            # Aliases for sanity
            local current=$x,$y
            local prev=$((x+1)),$y

            # Copy this bullet to the right
            bullet_grid[$prev]=${bullet_grid[$current]}

            # Clear this cell
            bullet_grid[$current]=$space
        done
    done

    # Delete any overlapping bullets and asteroids
    apply_bullets

    # Move everything else left one
    for ((y = 0; y < height; y++)); do
        local clear_next=""
        for ((x = 0; x < width; x++)); do
            # Aliases for sanity
            local current=$x,$y
            local prev=$((x-1)),$y

            # Check if this is a ship part
            if [ "${grid[$current]}" == "$ship_head" ] \
            || [ "${grid[$current]}" == "$ship_engine" ] \
            || [ "${grid[$current]}" == "$ship_exhaust" ]; then
                # Clear the next cell instead of shifting it
                clear_next="yep, get rid of it"
            else
                if [ "$clear_next" ]; then
                    # Clear this cell
                    grid[$current]=$space

                    # Reset the flag
                    clear_next=""
                else
                    # Copy this cell to the left
                    grid[$prev]=${grid[$current]}

                    # Clear this cell
                    grid[$current]=$space
                fi
            fi

        done
    done

    # Delete any overlapping bullets and asteroids
    apply_bullets
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
    elif [ "$direction" == "down" ] && [ $(can_move "$direction") == "y" ]; then # Moving down...
        # Clear the ship from the current position
        grid[0,$ship_y]=$space
        grid[1,$ship_y]=$space
        grid[2,$ship_y]=$space

        # Increment ship Y
        ship_y=$(($ship_y + 1))
    fi

    # Add the ship in the new position
    grid[0,$ship_y]=$ship_exhaust
    grid[1,$ship_y]=$ship_engine
    grid[2,$ship_y]=$ship_head
}

# Fires a bullet from the front of the ship
function shoot {
    bullet_grid[3,$ship_y]=$bullet
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
            if [ ${bullet_grid[$x,$y]} ]; then
                output="$output${bullet_grid[$x,$y]}"
            else
                output="$output${grid[$x,$y]}"
            fi
        done
        # Write a newline before we start the next row
        output="$output\n"
    done

    # Print out the grid
    echo -ne "$output"
}

##### BEGIN MAIN LOGIC #########################################################

# Create the game grid
# We'll be using an associative array as a hack for multi-dimensional arrays
# See https://stackoverflow.com/a/16487733/5189708
# Reading is quite simple: ${grid[x,y]}
# Writing is similar but without the braces: grid[x,y]
declare -A grid

# My mind is melting, so we'll make bullets an overlay and compare later
declare -A bullet_grid

# Initialise both grids to $space
for ((y=0; y < height; y++)); do
    for ((x=0; x < width; x++)); do
        grid[$x,$y]=$space
        bullet_grid[$x,$y]=$space
    done
done

# Generate an asteroid
generate_asteroid

# Clear the terminal
clear

# Apply the ship to the grid
# This should only have to happen once at the start of the game
add_ship

# Main game loop
while true; do
    local tick=$((tick+1))

    # Wait for a moment
    sleep 0.01

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
        [Dd])
            shoot # Let off a rock-crushing blast of energy
            ;;
    esac

    sidescroll

    # Draw the grid
    draw_grid

done
