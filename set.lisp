(defvar *numbers* '(one two three))

(defvar *shadings* '(solid striped outlined))

(defvar *colours* '(red purple green))

(defvar *shapes* '(oval diamond squiggle))

;; TODO random values if not provided
(defun make-card (number shading colour shape) (list :number number :shading shading :colour colour :shape shape))

;; TODO do better, skip field names
(defun print-card (card) (format t "~a~%" card))

(defun get-card-number-index (card) (position (getf card :number) *numbers*))
(defun compare-card-number-index (card1 card2) (< (get-card-number-index card1) (get-card-number-index card2)))

(defun sort-cards (card-list)
  (sort card-list #'compare-card-number-index))

;;; Extrapolate third

;; extract attribute from cards and put it into a list
(defun extract-attribute (card1 card2 attribute)
  (mapcar
    #'(lambda (card) (getf card attribute))
    (list card1 card2)))

;; get difference of global var and that list
(defun extrapolate (card1 card2)
  (lambda (list attribute)
   (car (set-difference list (extract-attribute card1 card2 attribute)))))

(defun extrapolate-card (card1 card2)
  (apply
   #'make-card
   (mapcar
    (extrapolate card1 card2)
    (list *numbers* *shadings* *colours* *shapes*)
    (list :number :shading :colour :shape))))

;;; Use all of the above

(let ((card1 (make-card (nth 1 *numbers*) (nth 1 *shadings*) (nth 0 *colours*) (nth 0 *shapes*)))
      (card2 (make-card (nth 0 *numbers*) (nth 1 *shadings*) (nth 1 *colours*) (nth 2 *shapes*)))
      (card3 (make-card (nth 2 *numbers*) (nth 1 *shadings*) (nth 2 *colours*) (nth 1 *shapes*)))
      (card4 (apply #'make-card '(one outlined purple oval)))
      (card5 (apply #'make-card '(three solid green diamond)))
      (board nil))
  (dolist (card (list card5 card2 card3 card4 card1))
    (push card board))
  (print-card (member-if #'(lambda (card) (equal card (extrapolate-card card1 card2))) board)))
