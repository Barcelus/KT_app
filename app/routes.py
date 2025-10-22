from flask import Blueprint, render_template, request
import random

main = Blueprint('main', __name__)

@main.route("/", methods=["GET", "POST"])
def index():
    result = None
    if request.method == "POST":
        try:
            num_dice = int(request.form.get("num_dice", 0))
            success_threshold = int(request.form.get("success_threshold", 6))
            
            # rzuty kostkami
            rolls = [random.randint(1,6) for _ in range(num_dice)]
            
            # zwykłe sukcesy
            successes = sum(1 for r in rolls if success_threshold <= r < 6)
            
            # krytyczne sukcesy (6)
            critical_successes = sum(1 for r in rolls if r == 6)
            
            result = {
                "rolls": rolls,
                "successes": successes,
                "critical_successes": critical_successes,
                "num_dice": num_dice,
                "success_threshold": success_threshold
            }
        except ValueError:
            result = {"error": "Proszę podać poprawne liczby."}
    
    return render_template("index.html", result=result)
