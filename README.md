#Command Line Interface Ruby Chess game
*This is a Player vs Player chess game played on the terminal
*Player first selects a chess piece and then selects the coordinate that they want \
to move to
##Things I learned / Used
*A lot of these ideas I got from ***rlmoser99***
*Observer design pattern
*Learned about Ruby Observable module and how to implement it. The observable module allowed me to use the `board` class as the subject and the `Piece` class as the observers. When an instance of `Piece` is created, it becomes the observer of the `Board` instance. So everytime a `Piece` moves, the `Board` changes and it notifies all the `Piece` observers about this change so that each `Piece` can update its new moves and captures.
