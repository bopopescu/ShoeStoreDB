from flask import Flask, render_template, request, redirect, url_for
from flask_mysqldb import MySQL

app = Flask(__name__)

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'Jocelyn!180'
app.config['MYSQL_DB'] = 'shoe_store'

mysql = MySQL(app)

# while True:
#     #username = input("Enter username: ")
#     #password = input("Enter password: ")
#     try:
#         cnx = pymysql.connect(host='localhost', user='root', password='Jocelyn!180', db='shoe_store')
#         cur = cnx.cursor()
#         if cnx:
#             break
#         else:
#             continue
#     except:
#         print('Couldn\'t connect to the server. Please enter credentials again.')
#


@app.route('/')
def ind():

    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM employee")
    data = cur.fetchall()
    cur.close()

    return render_template('index.html', employees = data)


@app.route('/insert', methods=['POST'])
def insert():
    if request.method == "POST":
        employee_id = request.form['employee_id']
        salary = request.form['salary']
        first_name = request.form['first_name']
        last_name = request.form['last_name']
        start_date = request.form['start_date']
        branch_id = request.form['branch_id']
        job_title = request.form['job_title']

        cur = mysql.connection.cursor()

        ins_st = '''INSERT INTO employee (employee_id, salary, first_name, last_name,
                    start_date, branch_id, job_title) VALUES ('{}', '{}', '{}', '{}', '{}','{}', '{}')'''.format(employee_id, salary, first_name, last_name, start_date, branch_id, job_title)
        print(ins_st)
        cur.execute(ins_st)

        mysql.connection.commit()
        return redirect(url_for('ind'))


@app.route('/update', methods= ['POST', 'GET'])
def update():
    if request.method == "POST":
        employee_id = request.form['employee_id']
        salary = request.form['salary']
        first_name = request.form['first_name']
        last_name = request.form['last_name']
        start_date = request.form['start_date']
        branch_id = request.form['branch_id']
        job_title = request.form['job_title']

        cur = mysql.connection.cursor()

        ins_st = '''UPDATE employee SET salary='{}', first_name='{}', last_name='{}',
                            start_date='{}', branch_id='{}', job_title='{}' 
                            WHERE employee_id='{}' '''.format(salary, first_name, last_name, start_date, branch_id, job_title, employee_id)
        cur.execute(ins_st)
        mysql.connection.commit()
        return redirect(url_for('ind'))


@app.route('/delete/<string:employee_id>', methods = ['POST', 'GET'] )
def delete(employee_id):

    cur = mysql.connection.cursor()
    cur.execute("DELETE FROM employee WHERE employee_id = %s", [employee_id])
    mysql.connection.commit()
    return redirect(url_for('ind'))


if __name__ == "__main__":
    # had app.run(debug=True) before for debugging purposes.
    app.run()
