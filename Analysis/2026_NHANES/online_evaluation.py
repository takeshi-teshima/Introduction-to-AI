import csv
import math

def clean_value(x):
    if x is None or x.strip() == "":
        return None
    # Remove single quotes and other characters that might interfere
    x = x.replace("'", "").replace(",", "").strip()
    try:
        return float(x)
    except ValueError:
        return None

# Define the model parameters
B0 = 65.98
B1 = 2.52

file_path = "第2回講義の任意課題提出フォーム：訓練済みモデルのオンライン性能.csv"

data = []
with open(file_path, mode='r', encoding='utf-8') as f:
    reader = csv.reader(f)
    header = next(reader)
    for row in reader:
        if not row: continue
        data.append(row)

# 1. Recalculated Evaluation (Requires raw inputs)
recalc_rows = []
# 2. Reported Evaluation (Uses student-filled error values)
reported_rows = []
# 3. Hybrid Evaluation (Recalculated when possible, fallback to reported)
hybrid_rows = []

for row in data:
    no = row[0]
    upper_leg = clean_value(row[1])
    standing_height = clean_value(row[2])
    error_input = clean_value(row[4])
    sq_error_input = clean_value(row[5])
    
    # Calculate Recalculated values if possible
    sq_err_recalc = None
    if upper_leg is not None and standing_height is not None:
        predicted = B0 + B1 * upper_leg
        sq_err_recalc = (standing_height - predicted) ** 2
        recalc_rows.append({'No': no, 'SqError': sq_err_recalc})
    
    # Calculate Reported values if possible
    sq_err_report = None
    if sq_error_input is not None:
        sq_err_report = sq_error_input
    elif error_input is not None:
        sq_err_report = error_input ** 2
    
    if sq_err_report is not None:
        reported_rows.append({'No': no, 'SqError': sq_err_report})
    
    # Hybrid Logic
    if sq_err_recalc is not None:
        hybrid_rows.append({'No': no, 'SqError': sq_err_recalc, 'Method': 'Recalculated'})
    elif sq_err_report is not None:
        hybrid_rows.append({'No': no, 'SqError': sq_err_report, 'Method': 'Reported Fallback'})

def calc_metrics(rows):
    n = len(rows)
    if n > 0:
        mse = sum(r['SqError'] for r in rows) / n
        rmse = math.sqrt(mse)
        return n, mse, rmse
    return 0, float('nan'), float('nan')

n_recalc, mse_recalc, rmse_recalc = calc_metrics(recalc_rows)
n_report, mse_report, rmse_report = calc_metrics(reported_rows)
n_hybrid, mse_hybrid, rmse_hybrid = calc_metrics(hybrid_rows)

offline_mse = 53.8358
offline_rmse = 7.3373

print("\n--- Evaluation Results (Online) ---")
print(f"{'Method':<30} | {'N':<3} | {'MSE':<10} | {'RMSE':<10}")
print("-" * 60)
print(f"{'Recalculated from Raw':<30} | {n_recalc:<3} | {mse_recalc:<10.4f} | {rmse_recalc:<10.4f}")
print(f"{'Based on Reported Errors':<30} | {n_report:<3} | {mse_report:<10.4f} | {rmse_report:<10.4f}")
print(f"{'Hybrid (Recalc + Fallback)':<30} | {n_hybrid:<3} | {mse_hybrid:<10.4f} | {rmse_hybrid:<10.4f}")

print("\n--- Offline Evaluation (Reference) ---")
print(f"{'Offline':<30} | {'-':<3} | {offline_mse:<10.4f} | {offline_rmse:<10.4f}")

print("\n--- Detailed Hybrid Data ---")
print(f"{'No':<5} | {'SqErr':<10} | {'Method':<20}")
for r in hybrid_rows:
    print(f"{r['No']:<5} | {r['SqError']:<10.2f} | {r['Method']:<20}")
