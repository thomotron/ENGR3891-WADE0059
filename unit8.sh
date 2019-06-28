#!/bin/bash

# THE AUTHOR OF THIS PROGRAM PROVIDES PERMISSION FOR IT TO BE REDISTRIBUTED ON
# THEIR BEHLF SOLELY FOR THE PURPOSE OF PEER REVIEW AND GRADING

# NOTE: THIS IS NOT THE ASSIGNMENT SUBMISSION. I'M JUST BEING EXTRA CAREFUL TO
#       MAKE SURE THIS GETS MARKED AS THE WORKSHOP. CHEERS AND THANK YOU!

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
space=" "

# Create the game grid
# We'll be using an associative array as a hack for multi-dimensional arrays
# See https://stackoverflow.com/a/16487733/5189708
# Reading is quite simple: ${grid[x,y]}
# Writing is similar but without the braces: grid[x,y]
declare -A grid

# My mind is melting, so we'll make bullets an overlay and compare later
declare -A bullet_grid

# Set up some variables for the main cannon
# Gotta make it challenging somehow, right?
magazine_size=15 # How many bullets we can hold in total
bullets_left=$magazine_size # Bullets left in the magazine, start with 10
ticks_per_bullet=8 # Ticks it will take to generate a new bullet
bullet_regen_timer=$ticks_per_bullet # Ticks until the next bullet is generated

# Set the difficulty (i.e. chance an asteroid will spawn)
# Read it as "One in X chance to spawn per tick"
# 10 is fairly easy
# 5 is somewhat difficult
# 1 is a wall of rock
asteroid_chance=7

# Set a flag that will break out of the main game loop
crashed=false

##### BEGIN PRE-FLIGHT CHECKS ##################################################

# Spit out an error if the terminal height or width are too small
if [ $(tput lines) -lt $height ] || [ $(tput cols) -lt $width ]; then
    echo "Your terminal height is too small, must be at least "$width"x"$height # I wanted something like '100x25' so the weird quotes will have to do
    exit 1
fi

##### BEGIN FUNCTIONS ##########################################################

# Generates an asteroid and adds it to the grid
function generate_asteroid {
    #local horz_radius=$(shuf -i 1-5 -n 1) # Get a radius between 1 and 5
    #local vert_radius=$((horz_radius*100/6*5/100)) # Get a vertical radius 5/6ths of the horizontal
    local radius=$(shuf -i 1-5 -n 1) # Get a radius between 1 and 5
    local centre=$(shuf -i 0-$height -n 1) # Get a random Y pos between 0 and $height

    # Make some boundary variables so I don't lose my mind trying to remember
    # what all of these calculations are
    #local left=$((width-centre-horz_radius))
    local left=$((width-centre-radius))
    local right=$((width-1))
    #local top=$((centre-vert_radius))
    #local bottom=$((centre+vert_radius))
    local top=$((centre-radius))
    local bottom=$((centre+radius))

    # Clamp top and bottom
    if [ $top -lt 0 ]; then top=0; fi
    if [ $bottom -gt $((height-1)) ]; then bottom=$((height-1)); fi

    # Draw the asteroid
    for ((y = top; y <= bottom; y++)); do
        for ((x = left; x <= right; x++)); do
            # TODO: Make circles
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
        local in_front_of_ship=""
        for ((x = 0; x < width; x++)); do
            # Aliases for sanity
            local current=$x,$y
            local prev=$((x-1)),$y

            # Check if this is a ship part
            if [ "${grid[$current]}" == "$ship_head" ] \
            || [ "${grid[$current]}" == "$ship_engine" ] \
            || [ "${grid[$current]}" == "$ship_exhaust" ]; then
                # Clear the next cell instead of shifting it
                in_front_of_ship="yep"
            else
                # Check if we are in front of the ship
                if [ "$in_front_of_ship" ]; then
                    # Check if there is going to be a collision
                    if [ "${grid[$current]}" == "$asteroid" ]; then
                        # Game over, dude
                        crashed=true

                        # Break out of the function
                        #return 1
                    else
                        # Clear this cell
                        grid[$current]=$space

                        # Reset the flag
                        in_front_of_ship=""
                    fi
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
    if [ "$direction" == "up" ] && [ "$(can_move "$direction")" == "y" ]; then # Moving up...
        # Clear the ship from the current position
        grid[0,$ship_y]=$space
        grid[1,$ship_y]=$space
        grid[2,$ship_y]=$space

        # Decrement ship Y
        ship_y=$(($ship_y - 1))
    elif [ "$direction" == "down" ] && [ "$(can_move "$direction")" == "y" ]; then # Moving down...
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

    # Check if the space contains $asteroid
    if [[ "$target_cells" =~ [$asteroid]+ ]]; then
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

    # Should we use plural 'shots' or 'shot'?
    if [ $bullets_left -eq 1 ]; then
        local rounds_plural="shot"
    else
        local rounds_plural="shots"
    fi

    # Print out how many bullets are left
    echo -n "You have $bullets_left/$magazine_size $rounds_plural left "

    # Check if the magazine is full
    if [ $bullets_left -eq $magazine_size ]; then
        # Say that the mag is full
        echo "(+0 (magazine full))     " # Spaces are a dirty fix to overwrite old brackets
    else
        # Print out how often a new bullet will generate
        echo "(+1 per $ticks_per_bullet ticks)     "
    fi

    # Print out the grid
    echo -ne "$output"
}

# Displays a game over message in the centre of the game area
function game_over {
    # Change the ship to make it look destroyed
    ship_head="*" # Explosion
    ship_engine="~" # Exhaust trail
    ship_exhaust=" " # Void

    # Draw the destroyed ship
    add_ship
    draw_grid

    # Calculate where to place the game over message
    local top=$((height/2-1)) # Top row
    local middle=$((height/2)) # Middle row
    local bottom=$((height/2+1)) # Bottom row
    local left=$((width/2-6)) # Left edge

    # Print out the game over message with some blank padding around it
    tput cup $top $left
    echo -n "             "
    tput cup $middle $left
    echo -n "  GAME OVER  "
    tput cup $bottom $left
    echo -n "             "

    # Set the cursor position to the bottom-right and print a newline to reset
    # for the terminal prompt
    tput cup $width $height
    echo
}

# Displays the controls and how to play
function show_instructions {
    # Clear the terminal
    clear

    # Print out a massive block of text
    echo ""
    echo "You wake up to rigorous shaking and warning alarms sounding off. Struggling to pull yourself out of the water-laden container, you stumble to your feet. It wasn't time for re-entry just yet, you'd only been in cryostasis for a few days! Opening the door to the cockpit you see asteroids everywhere. Millions of rocks floating as far as the eye could see... and you are heading straight for them! You throw yourself into the pilot's seat, flick on the plasma cannon pre-charger, and grip the controls. This might get messy..."
    echo ""
    echo "CONTROLS:"
    echo "W/S - Move ship up and down"
    echo "D - Fire cannon"
    echo ""
    echo "HOW TO PLAY:"
    echo "Avoid the constant battery of asteroids for as long as you can!"
    echo "Steer clear of them or shoot the plasma cannon to try bore through them."
    echo "Be careful though, the cannon has a limited magazine size and takes time to generate more rounds."
    echo ""
    echo "Press any key to start"

    echo -e $message

    # Wait for any key
    read
}

##### BEGIN MAIN LOGIC #########################################################

# Initialise both grids to $space
for ((y=0; y < height; y++)); do
    for ((x=0; x < width; x++)); do
        grid[$x,$y]=$space
        bullet_grid[$x,$y]=$space
    done
done

# Define a ship position
ship_y=10

# Pause and show the instructions on how to play
show_instructions

# Generate an asteroid
generate_asteroid

# Clear the terminal
clear

# Apply the ship to the grid
# This should only have to happen once at the start of the game
add_ship

# Main game loop
while ! $crashed; do
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
        [Dd]) # Using D for now since catching space didn't seem to work
            # Check if we have any bullets left
            if [ "$bullets_left" -gt 0 ]; then
                # Let off a rock-crushing blast of energy
                shoot

                # Remove a bullet from the magazine
                bullets_left=$((bullets_left-1))
            fi # Otherwise do nothing
            ;;
    esac

    # Check if a new bullet can be generated
    if [ $bullet_regen_timer -eq 0 ]; then
        # Check if the magazine has room for a new bullet
        if [ $bullets_left -lt $magazine_size ]; then
            # Generate a new bullet in the magazine
            bullets_left=$((bullets_left+1))

            # Reset the timer
            bullet_regen_timer=$ticks_per_bullet
        fi # Otherwise do nothing, leave the bullet that just got generated in
           # the generator, ready to get loaded in the mag when there is space
    else
        # Decrement the timer
        bullet_regen_timer=$((bullet_regen_timer-1))
    fi

    # At a one in $asteroid_chance chance...
    if [ $((RANDOM % asteroid_chance)) -eq 0 ]; then
        # Make an asteroid
        generate_asteroid
    fi

    # Progress the grids by one
    sidescroll

    # Draw the grid
    draw_grid
done

game_over
