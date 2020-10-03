"""Routes for main pages."""
from flask import Blueprint, render_template
from flask import current_app as app
from .assets import compile_main_assets

# Blueprint Configuration
main_bp = Blueprint('main_bp', __name__,
                    template_folder='templates',
                    static_folder='static')
compile_main_assets(app)


@main_bp.route('/', methods=['GET'])
def home():
    """Homepage route."""
    return render_template('index.html',
                           title='Flask-Blueprint Tutorial | Home',
                           template='home-template main',
                           body="Home")


@main_bp.route('/about', methods=['GET'])
def about():
    """About page route."""
    return render_template('index.html',
                           title='Flask-Blueprint Tutorial | About',
                           template='about-template main',
                           body="About")


@main_bp.route('/etc', methods=['GET'])
def etc():
    """Etc page route."""
    return render_template('index.html',
                           title='Flask-Blueprint Tutorial | Etc',
                           template='etc-template main',
                           body="Etc")