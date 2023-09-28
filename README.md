# Command Line Interface Ruby Chess game
* This is a Player vs Player chess game played on the terminal
* Player first selects a chess piece and then selects the coordinate that they want \
to move to
## Things I learned / Used
* A lot of these ideas I got from ***rlmoser99***
* Learned a lot about design patterns in object oriented programming, especially Strategy, Factory, Observer (used these three in this project)
* **Observer** design pattern
* Learned about Ruby Observable module and how to implement it. Ruby observable module allowed me to use the `Board` class as the subject and the `Piece` class as the observers. When an instance of `Piece` is created, it becomes the observer of the `Board` instance. So everytime a `Piece` moves, the `Board` changes and it notifies all the `Piece` observers about this change so that each `Piece` can update its new moves and captures.
* **Strategy** design pattern was the solution to changing how each piece moved depending on the type of movement. The context was the `Board` class and the types of movement, basic, castling, en passant were the strategies. Every piece has basic movement but when dealing with the `Pawn` or `King` class, it had subtle differences. Thus, the use of strategies made it easier to switch between each different algorithmn depending on the movement of a piece.
* **Factory** The `Board` passes a string to the Factory to know which type of movement to create.
## Project requirements
* Save and Load games 
* Player vs Player with legal moves and captures
* Tests using Rspec 
## Revisiting this project in the future
* I would definitely use Rspec to test certain methods 

