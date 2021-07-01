(defvar *numbers* '(one two three))

(defvar *shadings* '(solid striped outlined))

(defvar *colours* '(red purple green))

(defvar *shapes* '(oval diamond squiggle))

(defun make-card (number shading colour shape) (list :number number :shading shading :colour colour :shape shape))

(defun print-card (card) (format t "~a~%" card))

(let ((card1 (make-card (nth 1 *numbers*) (nth 1 *shadings*) (nth 0 *colours*) (nth 0 *shapes*)))
      (card2 (make-card (nth 0 *numbers*) (nth 1 *shadings*) (nth 1 *colours*) (nth 2 *shapes*)))
      (card3 (make-card (nth 2 *numbers*) (nth 1 *shadings*) (nth 2 *colours*) (nth 1 *shapes*))))
  (dolist (card (list card1 card2 card3)) (print-card card))
  )

(sort '(2 1 3 4 6 5) #'>)
